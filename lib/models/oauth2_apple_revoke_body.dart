import 'package:dears/models/member_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth2_apple_revoke_body.freezed.dart';
part 'oauth2_apple_revoke_body.g.dart';

@Freezed(toJson: true)
class OAuth2AppleRevokeBody with _$OAuth2AppleRevokeBody {
  const factory OAuth2AppleRevokeBody({
    required String uuid,
    required MemberRole memberRole,
  }) = _OAuth2AppleRevokeBody;

  @override
  Map<String, dynamic> toJson();
}
