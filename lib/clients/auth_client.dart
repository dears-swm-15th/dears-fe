import 'package:dears/models/member_create_body.dart';
import 'package:dears/models/member_create_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: "v1/auth")
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST("/shared/create")
  Future<MemberCreateResponse> createMember({
    @Body() required MemberCreateBody data,
  });
}
