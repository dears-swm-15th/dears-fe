import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/details_background_carousel.dart';
import 'package:dears/widgets/details_introduction_tab.dart';
import 'package:dears/widgets/details_review_tab.dart';
import 'package:dears/widgets/details_sliver_app_bar.dart';
import 'package:dears/widgets/details_sliver_tab_bar_delegate.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final int plannerId;

  const DetailsPage({
    super.key,
    required this.plannerId,
  });

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage>
    with SingleTickerProviderStateMixin {
  final keys = [GlobalKey(), GlobalKey()];

  late final ScrollController scrollController;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(animateTab);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void animateTab() {
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
  }

  Future<void> scrollToIndex(int index) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final portfolioList = ref.watch(portfolioListProvider);
    final portfolio = portfolioList.firstWhere((e) => e.id == widget.plannerId);

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
                    delegate: DetailsSliverTabBarDelegate(
                      controller: tabController,
                      onTap: scrollToIndex,
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
