import 'package:dears/models/chatroom.dart';
import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'chatroom_client.g.dart';

final ChatroomClient chatroomClient = ChatroomClient(dio);

@RestApi(baseUrl: "v1/chatroom")
abstract class ChatroomClient {
  factory ChatroomClient(Dio dio, {String baseUrl}) = _ChatroomClient;

  @POST("/shared/delete/{id}")
  Future<void> exit(@Path() int id);

  @POST("/customer/{portfolioId}")
  Future<Chatroom> createOrEnter(@Path() int portfolioId);

  @GET("/customer/all")
  Future<List<ChatroomOverview>> getAll();

  @POST("/customer/enter/{id}")
  Future<Chatroom> enter(@Path() int id);
}
