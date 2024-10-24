import 'dart:convert';

import 'package:dears/models/message.dart';
import 'package:dears/models/message_type.dart';
import 'package:dears/models/stomp_message.dart';
import 'package:dears/providers/access_token_provider.dart';
import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/is_signed_in_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/providers/uuid_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:dears/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'stomp_provider.g.dart';

@riverpod
class Stomp extends _$Stomp {
  @override
  Future<StompClient?> build() async {
    final isSignedIn = await ref.watch(isSignedInProvider);
    if (!isSignedIn) {
      return null;
    }

    final uuid = await ref.read(uuidProvider.future);

    // Read access token after fetching chat room list to ensure access token
    // is not expired. Even if access token is expired, the API call will
    // trigger a refresh, guaranteeing that the token is valid.
    final chatList = await ref.read(chatListProvider.future);
    final accessToken = await ref.read(accessTokenProvider.future);

    if (uuid == null || accessToken == null) {
      throw StateError("uuid or access token cannot be null after sign-in");
    }

    final client = StompClient(
      config: StompConfig.sockJS(
        url: "$baseUrl/stomp/chat",
        stompConnectHeaders: {"Authorization": accessToken},
        onConnect: (frame) {
          for (final chatroom in chatList) {
            subscribe(chatroom.id);
          }
          _listenNew(uuid);
        },
        onWebSocketError: (error) {
          logger.e(error);
          ref.read(authStateProvider.notifier).signOut();
        },
        onDebugMessage: logger.d,
      ),
    )..activate();
    ref.onDispose(client.deactivate);

    return client;
  }

  Future<void> subscribe(int chatroomId) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final role = await ref.read(roleProvider.future);

    final unsubscribeFn = client.subscribe(
      destination: "/sub/$chatroomId",
      callback: (frame) {
        final body = frame.body;
        if (body == null) {
          return;
        }

        final json = jsonDecode(body) as Map<String, dynamic>;
        final stompMessage = StompMessage.fromJson(json);
        if (stompMessage.type != MessageType.send) {
          return;
        }

        final message = Message(
          isMe: stompMessage.role == role,
          message: stompMessage.content,
          createdAt: DateTime.now(),
        );

        if (ref.exists(messageListProvider(chatroomId))) {
          ref.read(messageListProvider(chatroomId).notifier).add(message);
        }
        if (ref.exists(chatListProvider)) {
          ref.read(chatListProvider.notifier).add(chatroomId, message);
        }
      },
    );

    ref.onDispose(unsubscribeFn);
  }

  Future<void> _listenNew(String uuid) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final unsubscribeFn = client.subscribe(
      destination: "/sub/$uuid",
      callback: (frame) {
        final body = frame.body;
        if (body == null) {
          return;
        }

        final json = jsonDecode(body) as Map<String, dynamic>;
        final stompMessage = StompMessage.fromJson(json);
        if (stompMessage.type != MessageType.enter) {
          return;
        }

        subscribe(stompMessage.chatroomId);
        // Do not update `chatListProvider` not to let the user know
      },
    );

    ref.onDispose(unsubscribeFn);
  }

  Future<void> send(int chatroomId, String content) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final role = await ref.read(roleProvider.future);

    final stompMessage = StompMessage(
      type: MessageType.send,
      chatroomId: chatroomId,
      role: role,
      content: content,
    );

    client.send(
      destination: "/pub/${role.apiPrefix}/send",
      body: jsonEncode(stompMessage),
    );
  }
}
