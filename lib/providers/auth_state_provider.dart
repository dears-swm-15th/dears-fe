import 'package:dears/clients/oauth2_client.dart';
import 'package:dears/models/auth_token.dart';
import 'package:dears/models/kakao_oauth2_body.dart';
import 'package:dears/models/member_role.dart';
import 'package:dears/providers/oauth2_client_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  FutureOr<void> build() {}

  Future<void> signIn(OAuth2Provider provider) async {
    final token = await provider.getToken();
    if (token == null) {
      throw Exception("failed to get token");
    }

    final client = await ref.read(oauth2ClientProvider.future);

    final user = await ref.read(userInfoProvider.future);
    final role = user.role;

    final authToken = await provider.signIn(client, token, role);
    logger.d(authToken);
  }
}

sealed class OAuth2Provider {
  const OAuth2Provider();

  Future<String?> getToken();

  Future<AuthToken> signIn(OAuth2Client client, String token, MemberRole role);
}

class KakaoOAuth2Provider extends OAuth2Provider {
  const KakaoOAuth2Provider();

  @override
  Future<String?> getToken() async {
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      logger.d("trying to sign in with KakaoTalk");

      try {
        final token = await UserApi.instance.loginWithKakaoTalk();
        return token.accessToken;
      } catch (e) {
        logger.d("failed to sign in with KakaoTalk: $e");

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (e is PlatformException && e.code == "CANCELED") {
          return null;
        }

        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          final token = await UserApi.instance.loginWithKakaoAccount();
          return token.accessToken;
        } catch (e) {
          logger.d("failed to sign in with Kakao Account: $e");
          return null;
        }
      }
    } else {
      logger.d("trying to sign in with Kakao Account");

      try {
        final token = await UserApi.instance.loginWithKakaoAccount();
        return token.accessToken;
      } catch (e) {
        logger.d("failed to sign in with Kakao Account: $e");
        return null;
      }
    }
  }

  @override
  Future<AuthToken> signIn(OAuth2Client client, String token, MemberRole role) {
    final data = KakaoOAuth2Body(kakaoAccessToken: token, role: role);
    return client.signInWithKakao(data: data);
  }
}
