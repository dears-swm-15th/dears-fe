import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  final num rating;
  final Color color;

  const StarRatingBar({
    super.key,
    required this.rating,
    this.color = Colors.black,
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
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [color, Colors.transparent],
              stops: [rating, rating],
            ).createShader(bounds);
          },
          child: const Icon(
            Icons.star_rounded,
            size: 16,
            color: Colors.grey,
          ),
        );
      }),
    );
  }
}
