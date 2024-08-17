import 'package:dears/models/member_role.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required MemberRole role,
    String? uuid,
  }) = _User;

  static const defaultValue = User(role: MemberRole.defaultValue);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
