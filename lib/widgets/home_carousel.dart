import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const int _itemCount = 12;

class HomeCarousel extends HookWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final index = useState(0);

    return SizedBox(
      child: PageView.builder(
        controller: pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (value) => index.value = value,
        itemCount: _itemCount,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4.0), // 원하는 반경 값으로 설정
            child: Image.network(
              "https://picsum.photos/seed/image$index/600/400",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
