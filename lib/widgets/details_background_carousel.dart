import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const int _itemCount = 12;

class DetailsBackgroundCarousel extends HookWidget {
  const DetailsBackgroundCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final index = useState(0);

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + kToolbarHeight + 180,
          child: PageView.builder(
            controller: pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (value) => index.value = value,
            itemCount: _itemCount,
            itemBuilder: (context, index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length],
              );
            },
          ),
        ),
        Positioned(
          left: 16,
          bottom: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "${index.value + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: "/$_itemCount"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
