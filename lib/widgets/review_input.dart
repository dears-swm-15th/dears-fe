import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/review_cost_field.dart';
import 'package:dears/widgets/review_image_picker.dart';
import 'package:dears/widgets/review_keyword_chips.dart';
import 'package:dears/widgets/review_rating_selector.dart';
import 'package:dears/widgets/review_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewInput extends ConsumerWidget {
  final int portfolioId;

  const ReviewInput(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.type),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: "웨딩플래너 "),
                  TextSpan(
                    text: "$type\n",
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const TextSpan(text: "리뷰를 작성해주세요"),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ReviewRatingSelector(portfolioId),
        const SizedBox(height: 16),
        const Text("관련된 키워드를 모두 선택해주세요", style: titleSmall),
        const SizedBox(height: 10),
        ReviewKeywordChips(portfolioId),
        const SizedBox(height: 16),
        Text("솔직한 $type 리뷰를 남겨주세요", style: titleSmall),
        const SizedBox(height: 10),
        ReviewTextField(portfolioId),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: "이미지 첨부", style: titleSmall),
              TextSpan(
                text: "(선택)",
                style: bodySmall.copyWith(color: gray600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ReviewImagePicker(portfolioId),
        const SizedBox(height: 24),
        const Text("가격 정보를 입력해주세요", style: titleSmall),
        const SizedBox(height: 10),
        ReviewCostField(portfolioId),
      ],
    );
  }
}
