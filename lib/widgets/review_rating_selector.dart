import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String? _getRatingText(int rating) {
  return switch (rating) {
    1 || 2 => "아쉬워요",
    3 => "보통이에요",
    4 => "좋아요",
    5 => "최고에요",
    _ => null
  };
}

class ReviewRatingSelector extends ConsumerWidget {
  final int portfolioId;

  const ReviewRatingSelector(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.rating),
    );

    final ratingText = _getRatingText(rating);
    final text = ratingText == null
        ? const Text("별점을 입력해주세요", style: bodySmall)
        : RichText(
            text: TextSpan(
              style: bodySmall,
              children: [
                TextSpan(
                  text: "$rating점 ",
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
                onTap: () => ref
                    .read(reviewFormProvider(portfolioId).notifier)
                    .setRating(index + 1),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    DearsIcons.star,
                    color: index < rating ? yellow : gray100,
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
