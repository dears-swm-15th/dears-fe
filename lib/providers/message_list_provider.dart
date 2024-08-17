import 'package:dears/models/member_role.dart';
import 'package:dears/models/message.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/stomp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_provider.g.dart';

const MemberRole _role = MemberRole.customer;

@riverpod
class MessageList extends _$MessageList {
  @override
  Future<List<Message>> build(int chatroomId) async {
    final chatroomClient = ref.watch(chatroomClientProvider);
    final chatroom = await chatroomClient.enter(chatroomId);
    final chats = chatroom.chats;

    ref.onDispose(() {
      ref.read(stompProvider.notifier).leave(chatroomId);
    });

    return chats.map((e) {
      return Message(
        isMe: e.role == _role,
        message: e.content,
        createdAt: e.createdAt,
      );
    }).toList();
  }

  void add(Message message) {
    update(
      (data) => [...data, message],
      onError: (err, stackTrace) => [],
    );
  }
}
