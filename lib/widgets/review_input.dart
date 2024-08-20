import 'package:dears/models/review_type.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/review_image_picker.dart';
import 'package:dears/widgets/review_keyword_chips.dart';
import 'package:dears/widgets/review_rating_selector.dart';
import 'package:dears/widgets/review_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewInput extends HookWidget {
  final ReviewType type;

  const ReviewInput({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final isEmpty = useState(textController.text.isEmpty);

    useEffect(
      () {
        void listener() {
          isEmpty.value = textController.text.isEmpty;
        }

        textController.addListener(listener);
        return () => textController.removeListener(listener);
      },
      const [],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
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
        const ReviewRatingSelector(),
        const SizedBox(height: 16),
        const Text("관련된 키워드를 모두 선택해주세요", style: titleSmall),
        const SizedBox(height: 10),
        const ReviewKeywordChips(),
        const SizedBox(height: 16),
        const Text("솔직한 상담 리뷰를 남겨주세요", style: titleSmall),
        const SizedBox(height: 10),
        ReviewTextField(controller: textController),
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
        const ReviewImagePicker(),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: FilledButton(
            onPressed: isEmpty.value ? null : () {},
            child: const Text("리뷰 작성하기"),
          ),
        ),
      ],
    );
  }
}
