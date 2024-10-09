import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          color: blue50,
          width: double.infinity,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: gray800,
                fontSize: 25,
                fontWeight: FontWeight.w600,
                height: 32 / 25,
              ),
              children: [
                TextSpan(text: "Dears", style: TextStyle(color: blue500)),
                TextSpan(text: "에서\n"),
                TextSpan(text: "투명", style: TextStyle(color: blue500)),
                TextSpan(text: "하고 "),
                TextSpan(text: "합리적인\n웨딩 준비", style: TextStyle(color: blue500)),
                TextSpan(text: "하기!"),
              ],
            ),
          ),
        ),
        Positioned(
          right: 4,
          bottom: 0,
          child: Image.asset(
            "assets/balloon.png",
            width: 172,
          ),
        ),
      ],
    );
  }
}
