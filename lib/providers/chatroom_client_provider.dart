import 'package:dears/clients/chatroom_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatroom_client_provider.g.dart';

@riverpod
ChatroomClient chatroomClient(ChatroomClientRef ref) {
  final dio = ref.watch(apiDioProvider);
  return ChatroomClient(dio);
}
