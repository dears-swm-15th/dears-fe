import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final int chatroomId;

  const ChatPage({
    super.key,
    required this.chatroomId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("김소연 웨딩플래너"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(DearsIcons.more_vert),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(DearsIcons.favorite_outline),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: blue50,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        child: Text(
                          "7월 7일 (일)",
                          style: captionLarge.copyWith(color: gray800),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: true,
                      message:
                          "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: true,
                      isFirst: true,
                      message: "예식장 방문 일정도 조율하고 싶습니다. 이번 주말에 가능할까요?",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: true,
                      message: "네 잠시만요~",
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: false,
                      message: "확인 후 연락드리겠습니다^^",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: true,
                      isFirst: true,
                      message: "감사합니다",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        child: Text(
                          "7월 7일 (일)",
                          style: captionLarge.copyWith(color: gray800),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: true,
                      message:
                          "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: true,
                      isFirst: true,
                      message: "예식장 방문 일정도 조율하고 싶습니다. 이번 주말에 가능할까요?",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: true,
                      message: "네 잠시만요~",
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: false,
                      isFirst: false,
                      message: "확인 후 연락드리겠습니다^^",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChatBubble(
                      isMe: true,
                      isFirst: true,
                      message: "감사합니다",
                      createdAt: DateTime.now(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: 54,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(DearsIcons.link),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: "메시지를 입력해주세요",
                        hintStyle: bodySmall.copyWith(color: gray600),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: gray100,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(DearsIcons.paper_plane_right),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }
}
