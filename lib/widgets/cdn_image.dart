import 'package:dears/utils/env.dart';
import 'package:flutter/widgets.dart';

class CdnImage extends StatelessWidget {
  final String? src;
  final BoxFit? fit;
  final Widget fallback;

  const CdnImage(
    this.src, {
    super.key,
    this.fit,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final src = this.src;
    if (src == null || src.isEmpty) {
      return fallback;
    }

    return Image.network(
      "$cdnUrl/$src",
      fit: fit,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}
