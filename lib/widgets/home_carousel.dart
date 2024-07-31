import 'package:flutter/material.dart';

const int _itemCount = 5;

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return Image.network(
          "https://picsum.photos/seed/image$index/600/400",
          fit: BoxFit.cover,
        );
      },
    );
  }
}
