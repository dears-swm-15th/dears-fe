import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class HomeEditor extends StatelessWidget {
  final double height;

  const HomeEditor({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "웨딩에디터가 알려주는 웨딩 준비 전 꼭 읽어야 할 꿀팁!",
          style: bodySmall.copyWith(color: gray800),
        ),
      ],
    );
  }
}
