import 'package:dears/models/message.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/stomp_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_provider.g.dart';

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

    final role = (await ref.read(userInfoProvider.future)).role;

    return chats.map((e) {
      return Message(
        isMe: e.role == role,
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
