import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF364FC7).withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: const Color(0xFF364FC7).withOpacity(0.15),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const CircleAvatar(radius: 27),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("김소연", style: titleSmall),
                    const SizedBox(width: 4),
                    Text(
                      "블룸 웨딩",
                      style: bodySmall.copyWith(color: gray600),
                    ),
                    const Spacer(),
                    Text(
                      "5분 전",
                      style: captionSmall.copyWith(color: gray600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
                        style: captionLarge.copyWith(color: gray600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                        "1",
                        style: captionSmall.copyWith(color: white),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
