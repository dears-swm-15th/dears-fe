// ignore_for_file: invalid_annotation_target

import 'package:dears/models/chat.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom.freezed.dart';
part 'chatroom.g.dart';

@freezed
class Chatroom with _$Chatroom {
  const factory Chatroom({
    @JsonKey(name: "chatRoomId") required int id,
    @JsonKey(name: "messages") required List<Chat> chats,
  }) = _Chatroom;

  factory Chatroom.fromJson(Map<String, dynamic> json) =>
      _$ChatroomFromJson(json);
}
