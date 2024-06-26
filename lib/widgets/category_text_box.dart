import 'package:flutter/material.dart';

class CategoryTextBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final String category;
  final TextStyle? textStyle;

  const CategoryTextBox({
    super.key,
    this.padding,
    required this.backgroundColor,
    required this.category,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(category, style: textStyle),
    );
  }
}
