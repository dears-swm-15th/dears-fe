// ignore_for_file: invalid_annotation_target

import 'package:dears/models/member_role.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth2_withdraw_body.freezed.dart';
part 'oauth2_withdraw_body.g.dart';

@Freezed(toJson: true)
class OAuth2WithdrawBody with _$OAuth2WithdrawBody {
  const factory OAuth2WithdrawBody({
    @JsonKey(name: "UUID") required String uuid,
    required MemberRole role,
  }) = _OAuth2WithdrawBody;

  @override
  Map<String, dynamic> toJson();
}
