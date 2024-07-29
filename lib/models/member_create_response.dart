import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_create_response.freezed.dart';
part 'member_create_response.g.dart';

@freezed
class MemberCreateResponse with _$MemberCreateResponse {
  const factory MemberCreateResponse({
    required String uuid,
  }) = _MemberCreateResponse;

  factory MemberCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberCreateResponseFromJson(json);
}
