import 'dart:convert';

import 'package:dears/models/message.dart';
import 'package:dears/models/message_type.dart';
import 'package:dears/models/stomp_message.dart';
import 'package:dears/providers/access_token_provider.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/is_signed_in_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'stomp_provider.g.dart';

@Riverpod(keepAlive: true)
class Stomp extends _$Stomp {
  @override
  Future<StompClient?> build() async {
    final isSignedIn = await ref.watch(isSignedInProvider.future);
    if (!isSignedIn) {
      return null;
    }

    final uuid = await ref.read(accessTokenProvider.future);
    if (uuid == null) {
      return null;
    }

    final client = StompClient(
      config: StompConfig.sockJS(
        url: "$baseUrl/stomp/chat",
        stompConnectHeaders: {"Authorization": uuid},
        onConnect: _onConnect,
        onWebSocketError: kDebugMode ? print : (_) {},
        onDebugMessage: kDebugMode ? print : (_) {},
      ),
    )..activate();
    ref.onDispose(client.deactivate);

    return client;
  }

  void _onConnect(StompFrame frame) {
    ref.read(chatListProvider);
    _listenNew();
  }

  Future<StompUnsubscribe?> subscribe(int chatroomId) async {
    final client = await future;
    if (client == null) {
      return null;
    }

    final role = (await ref.read(userInfoProvider.future)).role;

    return client.subscribe(
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
        ref.read(chatListProvider.notifier).add(chatroomId, message);
      },
    );
  }

  Future<void> _listenNew() async {
    final client = await future;
    if (client == null) {
      return;
    }

    final uuid = (await ref.read(userInfoProvider.future)).uuid;
    if (uuid == null) {
      return;
    }

    client.subscribe(
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

        ref.invalidate(chatListProvider);
      },
    );
  }

  Future<void> send(int chatroomId, String content) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final role = (await ref.read(userInfoProvider.future)).role;

    final stompMessage = StompMessage(
      type: MessageType.send,
      chatroomId: chatroomId,
      role: role,
      content: content,
    );

    client.send(
      destination: "/pub/${role.stompPrefix}/send",
      body: jsonEncode(stompMessage),
    );
  }

  Future<void> leave(int chatroomId) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final role = (await ref.read(userInfoProvider.future)).role;

    final stompMessage = StompMessage(
      type: MessageType.leave,
      chatroomId: chatroomId,
      role: role,
      content: "Leave Chat Room",
    );

    client.send(
      destination: "/pub/${role.stompPrefix}/send",
      body: jsonEncode(stompMessage),
    );
  }
}
