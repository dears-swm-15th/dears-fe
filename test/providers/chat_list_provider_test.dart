import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  test("chatListProvider test", () {
    final now = DateTime.now();

    final list = [
      ChatroomOverview(
        id: 3,
        othersProfileImageUrl: "path/to/image",
        othersName: "김소연",
        lastMessage: "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
        lastMessageCreatedAt: now.subtract(const Duration(minutes: 5)),
        organizationName: "블룸 웨딩",
        portfolioId: 1,
        unreadMessageCount: 1,
      ),
      ChatroomOverview(
        id: 11,
        othersProfileImageUrl: "path/to/image",
        othersName: "박지훈",
        lastMessage: "드레스 피팅 일정 잡으셨나요? 이번 주말에 가능하신지 확인 부탁드려요.",
        lastMessageCreatedAt:
            DateUtils.dateOnly(now).add(const Duration(hours: 12, minutes: 7)),
        organizationName: "드림 데이즈",
        portfolioId: 1,
        unreadMessageCount: 9,
      ),
      ChatroomOverview(
        id: 7,
        othersProfileImageUrl: "path/to/image",
        othersName: "이정민",
        lastMessage: "꽃 장식 관련해서 몇 가지 아이디어를 보내드렸어요. 확인해 보시고 마음에 드는 스타일 말씀해 주세요.",
        lastMessageCreatedAt: now.subtract(const Duration(days: 1)),
        organizationName: "러브스토리 웨딩",
        portfolioId: 1,
        unreadMessageCount: 10,
      ),
      ChatroomOverview(
        id: 4,
        othersProfileImageUrl: "path/to/image",
        othersName: "최은지",
        lastMessage: "이번 주에 예식장 방문 가능하신가요? 견적도 함께 준비해 두겠습니다",
        lastMessageCreatedAt: DateTime(2023, 6, 5, 9),
        organizationName: "해피모먼트",
        portfolioId: 1,
        unreadMessageCount: 99,
      ),
    ];

    final container = createContainer(
      overrides: [
        chatListProvider.overrideWith(() => ChatListOverride(list)),
      ],
    );

    expectLater(
      container.read(chatListProvider.future),
      completion(isNotEmpty),
    );
  });
}

class ChatListOverride extends ChatList {
  final List<ChatroomOverview> _list;

  ChatListOverride(this._list);

  @override
  Future<List<ChatroomOverview>> build() async {
    return _list;
  }
}
