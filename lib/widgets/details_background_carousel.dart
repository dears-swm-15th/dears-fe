import 'package:dears/models/portfolio.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailsBackgroundCarousel extends HookWidget {
  final Portfolio portfolio;

  const DetailsBackgroundCarousel(
    this.portfolio, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    final itemCount = portfolio.weddingPhotoUrls.length;

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + toolbarHeight + 180,
          child: PageView.builder(
            physics: const ClampingScrollPhysics(),
            onPageChanged: (value) => index.value = value,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return CdnImage(
                portfolio.weddingPhotoUrls[index],
                fallback: const Center(
                  child: Text("이미지를 불러올 수 없습니다"),
                ),
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
                  TextSpan(text: "/$itemCount"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
