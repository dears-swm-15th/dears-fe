import 'package:dears/providers/message_list_provider.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:dears/widgets/chat_bubble.dart';
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

          yield ChatBubble(
            isMe: item.isMe,
            isFirst: item.isMe != prev?.isMe,
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
                  ...bubbles.map((e) => SliverToBoxAdapter(child: e)),
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
