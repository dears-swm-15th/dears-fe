import 'package:dears/utils/formats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PortfolioCreateCostField extends HookWidget {
  final ValueChanged<int?> onChanged;

  const PortfolioCreateCostField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: "상담 비용을 입력해주세요",
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      onChanged: (value) {
        final cost = int.tryParse(value);
        if (cost == null) {
          onChanged(null);
          controller.value = TextEditingValue.empty;
          return;
        }

        onChanged(cost);

        final text = number.format(cost);
        controller.value = TextEditingValue(
          text: "$text원",
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
