import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final TapRegionCallback? onTapOutside;

  const SearchTextField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        style: bodySmall,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          hintText: "검색어를 입력하세요",
          hintStyle: TextStyle(color: gray600),
          prefixIcon: Icon(DearsIcons.search, color: gray600),
          suffixIcon: Icon(DearsIcons.cancel, size: 16, color: gray600),
          filled: true,
          fillColor: blue50,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          onSubmitted?.call(search.format(value));
          controller?.clear();
        },
        onTapOutside: onTapOutside,
      ),
    );
  }
}
