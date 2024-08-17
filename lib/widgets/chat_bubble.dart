import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final bool isFirst;
  final String? profileImageUrl;
  final String message;
  final DateTime? createdAt;

  const ChatBubble({
    super.key,
    required this.isMe,
    required this.isFirst,
    this.profileImageUrl,
    required this.message,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isFirst
        ? const EdgeInsets.only(top: 20)
        : const EdgeInsets.only(top: 6);

    final mainAxisAlignment =
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    final foregroundColor = isMe ? white : gray800;
    final backgroundColor = isMe ? blue500 : white;

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(!isMe && isFirst ? 4 : 16),
      topRight: Radius.circular(isMe && isFirst ? 4 : 16),
      bottomLeft: const Radius.circular(16),
      bottomRight: const Radius.circular(16),
    );

    final createdAt = this.createdAt.andThen(time.format);

    return Padding(
      padding: padding,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (isMe) ...[
              const Spacer(),
              if (createdAt != null) ...[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    createdAt,
                    style: captionSmall.copyWith(color: gray600),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ] else ...[
              if (isFirst)
                Align(
                  alignment: Alignment.topCenter,
                  child: CdnImage.circle(
                    profileImageUrl,
                    dimension: 36,
                    fallback: const Icon(DearsIcons.person),
                  ),
                )
              else
                const SizedBox(width: 36),
              const SizedBox(width: 6),
            ],
            Flexible(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                ),
                child: Text(
                  message,
                  style: bodySmall.copyWith(color: foregroundColor),
                ),
              ),
            ),
            if (!isMe) ...[
              if (createdAt != null) ...[
                const SizedBox(width: 4),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    createdAt,
                    style: captionSmall.copyWith(color: gray600),
                  ),
                ),
              ],
              const Spacer(),
            ],
          ],
        ),
      ),
    );
  }
}
