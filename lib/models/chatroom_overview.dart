// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom_overview.freezed.dart';
part 'chatroom_overview.g.dart';

@freezed
class ChatroomOverview with _$ChatroomOverview {
  const factory ChatroomOverview({
    @JsonKey(name: "chatRoomId") required int id,
    String? othersProfileImageUrl,
    required String othersName,
    String? lastMessage,
    DateTime? lastMessageCreatedAt,
    required String organizationName,
    required int portfolioId,
    required int unreadMessageCount,
    @Default(false) bool isWishListed,
  }) = _ChatroomOverview;

  factory ChatroomOverview.fromJson(Map<String, dynamic> json) =>
      _$ChatroomOverviewFromJson(json);
}
