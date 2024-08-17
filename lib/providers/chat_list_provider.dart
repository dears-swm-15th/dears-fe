import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/models/message.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/providers/stomp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_list_provider.g.dart';

@Riverpod(keepAlive: true)
class ChatList extends _$ChatList {
  @override
  Future<List<ChatroomOverview>> build() async {
    final chatroomClient = ref.read(chatroomClientProvider);
    final list = await chatroomClient.getAll();

    final stomp = ref.read(stompProvider.notifier);
    for (final chatroom in list) {
      final unsubscribeFn = await stomp.subscribe(chatroom.id);
      ref.onDispose(unsubscribeFn);
    }

    return list;
  }

  void add(int chatroomId, Message message) {
    update(
      (data) {
        final i = data.indexWhere((e) => e.id == chatroomId);
        if (i == -1) {
          return data;
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
      },
      onError: (err, stackTrace) => [],
    );
  }
}
