import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom_overview.freezed.dart';
part 'chatroom_overview.g.dart';

@freezed
class ChatroomOverview with _$ChatroomOverview {
  const factory ChatroomOverview({
    required int id,
    required String othersProfileImageUrl,
    required String othersName,
    required String lastMessage,
    required DateTime lastMessageCreatedAt,
    required String organizationName,
    required int portfolioId,
  }) = _ChatroomOverview;

  factory ChatroomOverview.fromJson(Map<String, dynamic> json) =>
      _$ChatroomOverviewFromJson(json);
}
