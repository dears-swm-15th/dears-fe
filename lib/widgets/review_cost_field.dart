import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewCostField extends HookConsumerWidget {
  final int portfolioId;

  const ReviewCostField(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consultingFeeController = useTextEditingController();
    final consultingFeeFocusNode = useFocusNode();

    useEffect(
      () {
        void listener() {
          ref
              .read(reviewFormProvider(portfolioId).notifier)
              .setConsultingFee(consultingFeeController.text);
        }

        consultingFeeController.addListener(listener);
        return () => consultingFeeController.removeListener(listener);
      },
      const [],
    );

    final estimateController = useTextEditingController();
    final estimateFocusNode = useFocusNode();

    useEffect(
      () {
        void listener() {
          ref
              .read(reviewFormProvider(portfolioId).notifier)
              .setEstimate(estimateController.text);
        }

        estimateController.addListener(listener);
        return () => estimateController.removeListener(listener);
      },
      const [],
    );

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => consultingFeeFocusNode.requestFocus(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: gray100),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  const Text("상담비", style: titleSmall),
                  const SizedBox(height: 8),
                  TextField(
                    controller: consultingFeeController,
                    focusNode: consultingFeeFocusNode,
                    decoration: const InputDecoration.collapsed(
                      hintText: "입력하기",
                      hintStyle: TextStyle(color: blue500),
                    ),
                    keyboardType: TextInputType.number,
                    style: captionLarge.copyWith(color: blue500),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => estimateFocusNode.requestFocus(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: gray100),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  const Text("최종 견적", style: titleSmall),
                  const SizedBox(height: 8),
                  TextField(
                    controller: estimateController,
                    focusNode: estimateFocusNode,
                    decoration: const InputDecoration.collapsed(
                      hintText: "입력하기",
                      hintStyle: TextStyle(color: blue500),
                    ),
                    keyboardType: TextInputType.number,
                    style: captionLarge.copyWith(color: blue500),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
