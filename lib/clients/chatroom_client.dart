import 'package:dears/models/chatroom.dart';
import 'package:dears/models/chatroom_overview.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'chatroom_client.g.dart';

@RestApi(baseUrl: "v1/chatroom")
abstract class ChatroomClient {
  factory ChatroomClient(Dio dio, {String baseUrl}) = _ChatroomClient;

  @POST("/shared/delete/{id}")
  Future<void> exit(@Path() int id);

  @POST("/{role}/{portfolioId}")
  Future<Chatroom> createOrEnter(@Path() int portfolioId);

  @GET("/{role}/all")
  Future<List<ChatroomOverview>> getAll();

  @POST("/{role}/enter/{id}")
  Future<Chatroom> enter(@Path() int id);
}
