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

    final messageList = ref.watch(messageListProvider(chatroomId));

    final bubbles = messageList.maybeWhen<Iterable<Widget>>(
      data: (data) sync* {
        for (final (i, point) in data.indexed) {
          final newer = i == 0 ? null : data[i - 1];
          final older = i == data.length - 1 ? null : data[i + 1];

          DateTime? createdAt = point.createdAt;
          if (point.isMe == newer?.isMe &&
              isSameMinute(point.createdAt, newer?.createdAt)) {
            createdAt = null;
          }

          yield ChatBubble(
            chatroomId: chatroomId,
            isMe: point.isMe,
            isFirst: point.isMe != older?.isMe,
            message: point.message,
            createdAt: createdAt,
          );

          if (!DateUtils.isSameDay(point.createdAt, older?.createdAt)) {
            final date = fullDate.format(point.createdAt);

            yield Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  date,
                  style: captionLarge.copyWith(color: gray800),
                ),
              ),
            );
          }
        }
      },
      orElse: () => [],
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
            child: ListView(
              // Initially scroll to the bottom
              reverse: true,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                ...bubbles,
              ],
            ),
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
