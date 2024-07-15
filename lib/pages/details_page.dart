import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/details_background_carousel.dart';
import 'package:dears/widgets/details_introduction_tab.dart';
import 'package:dears/widgets/details_review_tab.dart';
import 'package:dears/widgets/details_sliver_app_bar.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsPage extends StatefulHookConsumerWidget {
  final int plannerId;

  const DetailsPage({
    super.key,
    required this.plannerId,
  });

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  final keys = [GlobalKey(), GlobalKey()];

  @override
  Widget build(BuildContext context) {
    final portfolioList = ref.watch(portfolioListProvider);
    final portfolio = portfolioList.firstWhere((e) => e.id == widget.plannerId);

    final scrollController = useScrollController();
    final tabController = useTabController(initialLength: 2);

    final animateTab = useCallback(() {
      final i = keys.lastIndexWhere((key) {
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox == null) {
          return false;
        }

        final offset = renderBox.localToGlobal(Offset.zero);
        return offset.dy <=
            MediaQuery.of(context).padding.top + kToolbarHeight + 44;
      });

      if (i == -1) {
        return;
      }

      tabController.animateTo(i);
    });

    final scrollToIndex = useCallback((int index) async {
      scrollController.removeListener(animateTab);

      final context = keys[index].currentContext;
      if (context == null) {
        return;
      }

      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
      );
      scrollController.addListener(animateTab);
    });

    useEffect(
      () {
        scrollController.addListener(animateTab);
        return () => scrollController.removeListener(animateTab);
      },
      [scrollController],
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  DetailsSliverAppBar(
                    title: Text("${portfolio.name} 웨딩플래너"),
                    actions: const [
                      FavoriteToggleButton(initialFavorite: false),
                      SizedBox(width: 14),
                    ],
                    background: Column(
                      children: [
                        const DetailsBackgroundCarousel(),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
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
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                            const Positioned(
                              top: -50,
                              right: 24,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(radius: 48),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      height: 44,
                      controller: tabController,
                      onTap: scrollToIndex,
                      tabs: [
                        Container(
                          alignment: Alignment.center,
                          height: 44,
                          child: const Text("소개"),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 44,
                          child: const Text("리뷰"),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      key: keys[0],
                      children: const [
                        DetailsIntroductionTab(),
                        Divider(thickness: 4),
                      ],
                    ),
                  ),
                ];
              },
              body: DetailsReviewTab(key: keys[1]),
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
                FilledButton(
                  style: FilledButton.styleFrom(
                    fixedSize: const Size(200, 50),
                  ),
                  onPressed: () {},
                  child: const Text("채팅하기"),
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
  final ValueChanged<int>? onTap;
  final List<Widget> tabs;

  const _SliverTabBarDelegate({
    required this.height,
    required this.controller,
    this.onTap,
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
        onTap: onTap,
        tabs: tabs,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}
