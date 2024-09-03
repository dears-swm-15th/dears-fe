import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListTile extends StatelessWidget {
  final ChatroomOverview chat;

  const ChatListTile(
    this.chat, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final message = chat.lastMessage ?? "";
    final createdAt = chat.lastMessageCreatedAt.andThen(recent.format) ?? "";

    return GestureDetector(
      onTap: () => context.push("/chats/${chat.id}"),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CdnImage.circle(
              chat.othersProfileImageUrl,
              dimension: 54,
              boxShadow: boxShadow,
              fallback: const Icon(DearsIcons.person, size: 28),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(chat.othersName, style: titleSmall),
                      const SizedBox(width: 4),
                      Text(
                        chat.organizationName,
                        style: bodySmall.copyWith(color: gray600),
                      ),
                      const Spacer(),
                      Text(
                        createdAt,
                        style: captionSmall.copyWith(color: gray600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: captionLarge.copyWith(color: gray600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (chat.unreadMessageCount > 0) ...[
                          const SizedBox(width: 18),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            constraints: const BoxConstraints(minWidth: 18),
                            decoration: const ShapeDecoration(
                              color: blue500,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              count.format(chat.unreadMessageCount),
                              style: captionSmall.copyWith(color: white),
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
