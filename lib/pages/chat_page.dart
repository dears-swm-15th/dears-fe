import 'package:dears/pages/loading_page.dart';
import 'package:dears/providers/chatroom_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:dears/widgets/chat_bubble.dart';
import 'package:dears/widgets/chat_text_field.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends ConsumerWidget {
  final int chatroomId;

  const ChatPage({
    super.key,
    required this.chatroomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatroom = ref.watch(chatroomProvider(chatroomId)).valueOrNull;
    if (chatroom == null) {
      return const LoadingPage();
    }

    final messages =
        ref.watch(messageListProvider(chatroomId)).valueOrNull ?? [];

    final bubbleListView = ListView.builder(
      // Initially scroll to the bottom
      reverse: true,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final point = messages[index];
        final newer = index == 0 ? null : messages[index - 1];
        final older = index == messages.length - 1 ? null : messages[index + 1];

        DateTime? createdAt = point.createdAt;
        if (point.isMe == newer?.isMe &&
            isSameMinute(point.createdAt, newer?.createdAt)) {
          createdAt = null;
        }

        Widget bubble = ChatBubble(
          chatroomId: chatroomId,
          isMe: point.isMe,
          isFirst: point.isMe != older?.isMe,
          message: point.message,
          createdAt: createdAt,
        );

        if (!DateUtils.isSameDay(point.createdAt, older?.createdAt)) {
          final date = fullDate.format(point.createdAt);

          bubble = Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    date,
                    style: captionLarge.copyWith(color: gray800),
                  ),
                ),
              ),
              bubble,
            ],
          );
        }

        if (newer == null) {
          bubble = Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: bubble,
          );
        }

        return bubble;
      },
    );

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: Text("${chatroom.othersName} 웨딩플래너"),
        actions: [
          FavoriteToggleButton(chatroom.portfolioId),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: blue50,
          child: Align(
            alignment: Alignment.topCenter,
            child: bubbleListView,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom,
        ),
        child: ChatTextField(chatroomId: chatroomId),
      ),
    );
  }
}
