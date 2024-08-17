import 'dart:convert';

import 'package:dears/models/member_role.dart';
import 'package:dears/models/message.dart';
import 'package:dears/models/message_type.dart';
import 'package:dears/models/stomp_message.dart';
import 'package:dears/providers/access_token_provider.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/is_signed_in_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'stomp_provider.g.dart';

const MemberRole _role = MemberRole.customer;
const String _roleString = "customer";

@Riverpod(keepAlive: true)
class Stomp extends _$Stomp {
  @override
  StompClient build() {
    final isSignedIn = ref.watch(isSignedInProvider).value;
    if (isSignedIn != true) {
      throw Exception("user is not signed in");
    }

    final uuid = ref.read(accessTokenProvider).unwrapPrevious().value;
    if (uuid == null) {
      throw Exception("user id is needed to connect to stomp");
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

  StompUnsubscribe subscribe(int chatroomId) {
    return state.subscribe(
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
          isMe: stompMessage.role == _role,
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

  void _listenNew() {
    final uuid = ref.read(accessTokenProvider).unwrapPrevious().value;
    if (uuid == null) {
      return;
    }

    state.subscribe(
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

  void send(int chatroomId, String content) {
    final stompMessage = StompMessage(
      type: MessageType.send,
      chatroomId: chatroomId,
      role: _role,
      content: content,
    );

    state.send(
      destination: "/pub/$_roleString/send",
      body: jsonEncode(stompMessage),
    );
  }

  void leave(int chatroomId) {
    final stompMessage = StompMessage(
      type: MessageType.leave,
      chatroomId: chatroomId,
      role: _role,
      content: "Leave Chat Room",
    );

    state.send(
      destination: "/pub/$_roleString/send",
      body: jsonEncode(stompMessage),
    );
  }
}
