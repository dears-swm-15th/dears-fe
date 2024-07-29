import 'package:dears/models/member_role.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_create_body.freezed.dart';
part 'member_create_body.g.dart';

@Freezed(toJson: true)
class MemberCreateBody with _$MemberCreateBody {
  const factory MemberCreateBody({
    required MemberRole role,
  }) = _MemberCreateBody;

  @override
  Map<String, dynamic> toJson();
}
