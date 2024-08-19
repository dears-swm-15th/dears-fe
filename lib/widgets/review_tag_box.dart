import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class ReviewTagBox extends StatelessWidget {
  final String tag;

  const ReviewTagBox(
    this.tag, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 28,
      decoration: BoxDecoration(
        color: gray100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(tag, style: captionLarge),
        ],
      ),
    );
  }
}
