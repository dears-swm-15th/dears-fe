import 'package:flutter/material.dart';

class PortfolioDescriptionField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const PortfolioDescriptionField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "자세한 설명을 작성해주세요",
      ),
      maxLines: null,
      minLines: 10,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
