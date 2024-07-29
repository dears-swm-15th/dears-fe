import 'package:dears/models/member_create_body.dart';
import 'package:dears/models/member_create_response.dart';
import 'package:dears/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

final AuthClient authClient = AuthClient(dio);

@RestApi(baseUrl: "v1/auth")
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST("/shared/create")
  Future<MemberCreateResponse> createMember({
    @Body() required MemberCreateBody data,
  });
}
