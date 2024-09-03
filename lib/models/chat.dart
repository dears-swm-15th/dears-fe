// ignore_for_file: invalid_annotation_target

import 'package:dears/models/chatroom.dart';
import 'package:dears/models/member_role.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

/// Data class for chat messages in the [Chatroom].
@freezed
class Chat with _$Chat {
  const factory Chat({
    required int id,
    @JsonKey(name: "senderRole") required MemberRole role,
    required String content,
    required DateTime createdAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
