import 'package:dears/providers/chat_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_ids_provider.g.dart';

/// Cached chat room id list mapped by portfolio id.
@Riverpod(keepAlive: true)
Future<Map<int, int>> chatRoomIds(Ref ref) async {
  final chatRooms = await ref.watch(chatListProvider.future);
  return {for (final e in chatRooms) e.portfolioId: e.id};
}
