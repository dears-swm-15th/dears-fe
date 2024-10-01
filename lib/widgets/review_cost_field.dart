import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewCostField extends HookWidget {
  final int portfolioId;
  final String label;
  final ValueChanged<int?> onChanged;

  const ReviewCostField({
    super.key,
    required this.portfolioId,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: gray100),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(label, style: titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              focusNode: focusNode,
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
              onChanged: (value) {
                onChanged(int.tryParse(value));
              },
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ],
        ),
      ),
    );
  }
}
