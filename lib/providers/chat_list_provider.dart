import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/models/message.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_list_provider.g.dart';

@riverpod
class ChatList extends _$ChatList {
  @override
  Future<List<ChatroomOverview>> build() async {
    final chatroomClient = await ref.watch(chatroomClientProvider.future);
    return chatroomClient.getAll();
  }

  Future<void> add(int chatroomId, Message message) async {
    state = await AsyncValue.guard(() async {
      final data = await future;

      final i = data.indexWhere((e) => e.id == chatroomId);
      if (i == -1) {
        ref.invalidateSelf();
        return await future;
      }

      final overview = data[i];
      data.removeAt(i);

      final unreadCount = ref.exists(messageListProvider(chatroomId))
          ? 0
          : overview.unreadMessageCount + 1;

      final newOverview = overview.copyWith(
        lastMessage: message.message,
        lastMessageCreatedAt: message.createdAt,
        unreadMessageCount: unreadCount,
      );
      return [newOverview, ...data];
    });
  }
}
