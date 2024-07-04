import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/details_introduction_tab.dart';
import 'package:dears/widgets/details_review_tab.dart';
import 'package:dears/widgets/details_sliver_app_bar.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsPage extends HookConsumerWidget {
  final int plannerId;

  const DetailsPage({
    super.key,
    required this.plannerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioList = ref.watch(portfolioListProvider);
    final portfolio = portfolioList.firstWhere((e) => e.id == plannerId);

    final scrollController = useScrollController();
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  DetailsSliverAppBar(
                    pinned: true,
                    centerTitle: true,
                    title: Text(
                      "${portfolio.name} 웨딩플래너",
                      style: const TextStyle(fontSize: 16),
                    ),
                    actions: const [
                      FavoriteToggleButton(initialFavorite: false),
                      SizedBox(width: 14),
                    ],
                    background: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: MediaQuery.of(context).padding.top +
                                  kToolbarHeight +
                                  180,
                              color: Colors.grey,
                            ),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text: "1",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: "/4"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 24,
                              bottom: -50,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(radius: 48),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    portfolio.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(portfolio.organization),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD7D9DB),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: const Text(
                                      "여성",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "결혼을 준비하는 모든 커플들의 꿈을 이뤄드리는 웨딩 플래너 김지수입니다.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      height: 44,
                      controller: tabController,
                      tabs: [
                        Container(
                          alignment: Alignment.center,
                          height: 44,
                          child: const Text(
                            "소개",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 44,
                          child: const Text(
                            "리뷰",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: const [
                  DetailsIntroductionTab(),
                  DetailsReviewTab(),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "200,000원~",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "평균 250,000원",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "채팅하기",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final TabController controller;
  final List<Widget> tabs;

  const _SliverTabBarDelegate({
    required this.height,
    required this.controller,
    required this.tabs,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        controller: controller,
        tabs: tabs,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
