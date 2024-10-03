import 'package:dears/models/inquiry_request_body.dart';
import 'package:dears/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'mypage_client.g.dart';

@RestApi(baseUrl: "v1/member/mypage")
abstract class MypageClient {
  factory MypageClient(Dio dio, {String baseUrl}) = _MypageClient;

  @GET("/{role}/me")
  Future<Profile> getProfile();

  @POST("/{role}/customerservice")
  Future<void> submit({
    @Body() required InquiryRequestBody data,
  });
}
