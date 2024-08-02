import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/home_carousel.dart';
import 'package:dears/widgets/home_editor.dart';
import 'package:dears/widgets/home_navigation_bar.dart';
import 'package:dears/widgets/home_top_viewed_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        leadingWidth: 44 + 16,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: ColoredBox(color: Colors.grey),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            icon: const Icon(DearsIcons.search),
          ),
          IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            icon: const Icon(DearsIcons.notifications),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(
            height: 176,
            child: HomeCarousel(),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "완벽한 결혼을 위한 가이드",
                      style: bodySmall.copyWith(color: blue50),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "웨딩 준비 로드맵 보러가기",
                      style: titleMedium.copyWith(color: white),
                    ),
                  ],
                ),
                const ColoredBox(
                  color: Colors.grey,
                  child: SizedBox.square(dimension: 56),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text("이번 주 주목할 웨딩플래너", style: titleLarge),
          const SizedBox(height: 10),
          const HomeTopViewedList(),
          const SizedBox(height: 24),
          const Text("디어스 매거진", style: titleLarge),
          const SizedBox(height: 4),
          Text(
            "웨딩 전문 에디터가 알려주는 웨딩 준비 전 꼭 읽어야 할 꿀팁!",
            style: bodySmall.copyWith(color: gray600),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    HomeEditor(height: 120),
                    SizedBox(height: 12),
                    HomeEditor(height: 212),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    HomeEditor(height: 212),
                    SizedBox(height: 12),
                    HomeEditor(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}
