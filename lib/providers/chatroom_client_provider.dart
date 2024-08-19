import 'package:dears/clients/chatroom_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatroom_client_provider.g.dart';

@riverpod
Future<ChatroomClient> chatroomClient(ChatroomClientRef ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return ChatroomClient(dio);
}