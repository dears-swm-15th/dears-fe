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
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 32),
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 12),
            onPressed: () {},
            icon: const Icon(Icons.notifications, size: 32),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 160,
            child: const HomeCarousel(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              "이번 주 주목할 웨딩플래너",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const HomeTopViewedList(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.bottomLeft,
            child: const Text(
              "웨딩플래닝 로드맵",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.bottomLeft,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "디어스 매거진",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "웨딩 전문 에디터가 알려주는 웨딩 준비 전 꼭 읽어야 할 꿀팁!",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const HomeEditor(),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}
