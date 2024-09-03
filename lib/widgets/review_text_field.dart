import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewTextField extends HookConsumerWidget {
  final int portfolioId;

  const ReviewTextField(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    useEffect(
      () {
        void listener() {
          ref
              .read(reviewFormProvider(portfolioId).notifier)
              .setContent(controller.text);
        }

        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      const [],
    );

    ref.listen(
      reviewFormProvider(portfolioId).select((value) => value.content),
      (previous, next) {
        if (controller.text != next) {
          controller.text = next;
        }
      },
    );

    return TextField(
      controller: controller,
      style: bodySmallLong,
      decoration: const InputDecoration(
        hintText: "다른 사용자들의 결혼 준비에 도움이 되도록 상세한 리뷰를 작성해주세요.",
        hintStyle: TextStyle(color: gray600),
        hintMaxLines: 3,
        counterStyle: TextStyle(color: gray600),
        contentPadding: EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: gray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blue500),
        ),
      ),
      maxLines: null,
      minLines: 3,
      maxLength: 1000,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
