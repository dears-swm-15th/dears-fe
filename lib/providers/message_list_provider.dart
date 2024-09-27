import 'package:dears/models/message.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_provider.g.dart';

/// List of messages in a chatroom ordered by [Message.createdAt]
/// in **descending** order.
@riverpod
class MessageList extends _$MessageList {
  @override
  Future<List<Message>> build(int chatroomId) async {
    final chatroomClient = await ref.watch(chatroomClientProvider.future);

    final chatroom = await chatroomClient.enter(chatroomId);
    // TODO: do not send leave message until server supports it
    // ref.onDispose(() {
    //   ref.read(stompProvider.notifier).leave(chatroomId);
    // });

    final chats = chatroom.chats;
    final role = await ref.read(roleProvider.future);

    return chats.reversed.map((e) {
      return Message(
        isMe: e.role == role,
        message: e.content,
        createdAt: e.createdAt,
      );
    }).toList();
  }

  Future<void> add(Message message) async {
    state = await AsyncValue.guard(() async {
      final data = await future;
      return [message, ...data];
    });
  }
}
