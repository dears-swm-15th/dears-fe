import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

/// Minimal data class for chat messages to display on the UI.
@freezed
class Message with _$Message {
  const factory Message({
    required bool isMe,
    required String message,
    required DateTime createdAt,
  }) = _Message;
}
