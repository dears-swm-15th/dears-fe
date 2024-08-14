// ignore_for_file: invalid_annotation_target

import 'package:dears/models/member_role.dart';
import 'package:dears/models/message_type.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stomp_message.freezed.dart';
part 'stomp_message.g.dart';

/// Data class for messages sent over the STOMP protocol.
@freezed
class StompMessage with _$StompMessage {
  const factory StompMessage({
    @JsonKey(name: "messageType") required MessageType type,
    @JsonKey(name: "chatRoomId") required int chatroomId,
    @JsonKey(name: "senderRole") required MemberRole role,
    required String content,
  }) = _StompMessage;

  factory StompMessage.fromJson(Map<String, dynamic> json) =>
      _$StompMessageFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
