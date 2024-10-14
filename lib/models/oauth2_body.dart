import 'package:dears/models/member_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth2_body.freezed.dart';
part 'oauth2_body.g.dart';

sealed class OAuth2Body {}

@Freezed(toJson: true)
class GoogleOAuth2Body extends OAuth2Body with _$GoogleOAuth2Body {
  const factory GoogleOAuth2Body({
    required String googleAccessToken,
    required MemberRole role,
  }) = _GoogleOAuth2Body;

  @override
  Map<String, dynamic> toJson();
}

@Freezed(toJson: true)
class KakaoOAuth2Body extends OAuth2Body with _$KakaoOAuth2Body {
  const factory KakaoOAuth2Body({
    required String kakaoAccessToken,
    required MemberRole role,
  }) = _KakaoOAuth2Body;

  @override
  Map<String, dynamic> toJson();
}
