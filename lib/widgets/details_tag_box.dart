import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class DetailsTagBox extends StatelessWidget {
  final String tag;

  const DetailsTagBox(
    this.tag, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      height: 18,
      decoration: BoxDecoration(
        color: blue50,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        tag,
        style: captionSmall.copyWith(
          color: blue500,
          height: 1,
        ),
      ),
    );
  }
}
