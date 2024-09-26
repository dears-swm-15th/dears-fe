import 'package:dears/models/auth_token.dart';
import 'package:dears/models/kakao_oauth2_body.dart';
import 'package:dears/models/reissue_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth2_client.g.dart';

@RestApi(baseUrl: "v1/oauth2")
abstract class OAuth2Client {
  factory OAuth2Client(Dio dio, {String baseUrl}) = _OAuth2Client;

  @POST("/shared/kakao")
  Future<AuthToken> signInWithKakao({
    @Body() required KakaoOAuth2Body data,
  });

  @POST("/shared/reissue")
  Future<ReissueResponse> reissue(@Field() String refreshToken);
}
