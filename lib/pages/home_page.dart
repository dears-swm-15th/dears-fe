import 'package:dears/providers/wishlist_provider.dart';
import 'package:dears/widgets/best_portfolio_list_title.dart';
import 'package:dears/widgets/home_carousel.dart';
import 'package:dears/widgets/home_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioList = ref.watch(wishlistProvider).asData?.value;

    if (portfolioList == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
          Column(
            children: List.generate(
              portfolioList.length,
              (index) {
                final portfolio = portfolioList[index];
                return BestPortfolioListTitle(portfolio);
              },
            ),
          ),
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
          const _Editor(),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}

class _Editor extends StatelessWidget {
  const _Editor();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 120,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 168,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 168,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 120,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
