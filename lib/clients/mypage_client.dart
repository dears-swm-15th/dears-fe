import 'package:dears/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'mypage_client.g.dart';

@RestApi(baseUrl: "v1/mypage")
abstract class MypageClient {
  factory MypageClient(Dio dio, {String baseUrl}) = _MypageClient;

  @GET("/customer/me")
  Future<Profile> getProfile();
}
