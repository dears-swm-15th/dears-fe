import 'dart:convert';

import 'package:dears/models/message.dart';
import 'package:dears/models/message_type.dart';
import 'package:dears/models/stomp_message.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:dears/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'stomp_provider.g.dart';

@riverpod
class Stomp extends _$Stomp {
  @override
  Future<StompClient?> build() async {
    final uuid = await ref.watch(
      userInfoProvider.selectAsync((data) => data.uuid),
    );
    if (uuid == null) {
      return null;
    }

    final client = StompClient(
      config: StompConfig.sockJS(
        url: "$baseUrl/stomp/chat",
        stompConnectHeaders: {"Authorization": uuid},
        onConnect: _onConnect,
        onWebSocketError: logger.e,
        onDebugMessage: logger.d,
      ),
    )..activate();
    ref.onDispose(client.deactivate);

    return client;
  }

  Future<void> _onConnect(StompFrame frame) async {
    final chatList = await ref.read(chatListProvider.future);
    for (final chatroom in chatList) {
      subscribe(chatroom.id);
    }
    _listenNew();
  }

  Future<void> subscribe(int chatroomId) async {
    final client = await future;
    if (client == null) {
      return;
    }

    final role = (await ref.read(userInfoProvider.future)).role;

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

  Future<void> _listenNew() async {
    final client = await future;
    if (client == null) {
      return;
    }

    final uuid = (await ref.read(userInfoProvider.future)).uuid;
    if (uuid == null) {
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

    final role = (await ref.read(userInfoProvider.future)).role;

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
      destination: "/pub/${role.apiPrefix}/send",
      body: jsonEncode(stompMessage),
    );
  }
}
