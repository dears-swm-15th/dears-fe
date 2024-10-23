import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatroom_provider.g.dart';

@riverpod
Future<ChatroomOverview> chatroom(Ref ref, int chatroomId) async {
  final chatList = await ref.watch(chatListProvider.future);
  return chatList.singleWhere((e) => e.id == chatroomId);
}
