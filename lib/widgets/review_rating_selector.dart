import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

String? _getRatingText(int rating) {
  return switch (rating) {
    1 || 2 => "아쉬워요",
    3 => "보통이에요",
    4 => "좋아요",
    5 => "최고에요",
    _ => null
  };
}

class ReviewRatingSelector extends HookWidget {
  const ReviewRatingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final rating = useState(0);

    final ratingText = _getRatingText(rating.value);
    final text = ratingText == null
        ? const Text("별점을 입력해주세요", style: bodySmall)
        : RichText(
            text: TextSpan(
              style: bodySmall,
              children: [
                TextSpan(
                  text: "${rating.value}점 ",
                  style: const TextStyle(color: blue500),
                ),
                TextSpan(text: ratingText),
              ],
            ),
          );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(5, (index) {
              return GestureDetector(
                onTap: () => rating.value = index + 1,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    DearsIcons.star,
                    color: index < rating.value ? yellow : gray100,
                  ),
                ),
              );
            }),
          ],
        ),
        text,
      ],
    );
  }
}
