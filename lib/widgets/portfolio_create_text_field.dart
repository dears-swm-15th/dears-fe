import 'package:flutter/material.dart';

class PortfolioCreateTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String> onChanged;

  const PortfolioCreateTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
