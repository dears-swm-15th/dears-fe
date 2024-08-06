import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  final num rating;

  const StarRatingBar(
    this.rating, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double rating = (this.rating - index).clamp(0, 1).toDouble();
        rating = 1 / 8 + rating * 3 / 4;

        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: LinearGradient(
            colors: const [yellow, Colors.transparent],
            stops: [rating, rating],
          ).createShader,
          child: const Icon(DearsIcons.star, size: 16, color: gray100),
        );
      }),
    );
  }
}
