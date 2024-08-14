import 'dart:math';

import 'package:dears/models/chatroom_overview.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
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
    final unreadCount = min(chat.unreadMessageCount, 99);

    return GestureDetector(
      onTap: () => context.push("/chats/${chat.id}"),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: boxShadow,
              ),
              child: CircleAvatar(radius: 27),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: captionLarge.copyWith(color: gray600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0) ...[
                        const SizedBox(width: 18),
                        Container(
                          alignment: Alignment.center,
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: blue500,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "$unreadCount",
                            style: captionSmall.copyWith(color: white),
                          ),
                        ),
                      ],
                      const SizedBox(width: 6),
                    ],
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
