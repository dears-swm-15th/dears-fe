import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class ReviewTextField extends StatelessWidget {
  final TextEditingController controller;

  const ReviewTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: bodySmallLong,
      decoration: const InputDecoration(
        hintText: "다른 사용자들의 결혼 준비에 도움이 되도록 상세한 리뷰를 작성해주세요.",
        hintStyle: TextStyle(color: gray600),
        hintMaxLines: 3,
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
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
