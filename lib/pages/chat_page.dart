import 'package:dears/providers/chatroom_provider.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:dears/widgets/chat_bubble.dart';
import 'package:dears/widgets/chat_text_field.dart';
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
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final messageList = ref.watch(messageListProvider(chatroomId));

    final bubbles = messageList.maybeWhen<Iterable<Widget>>(
      data: (data) sync* {
        for (final (i, item) in data.indexed) {
          final prev = i == 0 ? null : data[i - 1];
          final next = i == data.length - 1 ? null : data[i + 1];

          if (!DateUtils.isSameDay(item.createdAt, prev?.createdAt)) {
            final date = fullDate.format(item.createdAt);

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

          DateTime? createdAt = item.createdAt;
          if (item.isMe == next?.isMe &&
              isSameMinute(item.createdAt, next?.createdAt)) {
            createdAt = null;
          }

          final isMe = item.isMe;
          final isFirst = item.isMe != prev?.isMe;
          final profileImageUrl =
              !isMe && isFirst ? chatroom.othersProfileImageUrl : null;

          yield ChatBubble(
            isMe: isMe,
            isFirst: isFirst,
            profileImageUrl: profileImageUrl,
            message: item.message,
            createdAt: createdAt,
          );
        }
      },
      orElse: () => [],
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${chatroom.othersName} 웨딩플래너"),
        actions: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(DearsIcons.more_vert),
          ),
          FavoriteToggleButton(chatroom.portfolioId),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: blue50,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            ...bubbles.map((e) => SliverToBoxAdapter(child: e)),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ],
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
