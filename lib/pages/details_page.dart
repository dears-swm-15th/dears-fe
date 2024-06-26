import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/details_review_tab.dart';
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
      appBar: AppBar(
        actions: const [
          FavoriteToggleButton(initialFavorite: false),
          SizedBox(width: 14),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 180,
                              color: Colors.grey,
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(height: 36),
                        const Text(
                          "상세 정보",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text("활동지역"),
                            ),
                            SizedBox(width: 20),
                            Text("서울 전체"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text("상담가능시간"),
                            ),
                            SizedBox(width: 20),
                            Text("오전 9:00 ~ 오후 6:00"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text("휴무일"),
                            ),
                            SizedBox(width: 20),
                            Text("매주 월요일"),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "제공 서비스",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 10),
                            Text("서비스1"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 10),
                            Text("서비스2"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.check, size: 20),
                            SizedBox(width: 10),
                            Text("서비스3"),
                          ],
                        ),
                        const SizedBox(height: 40),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: "해당 웨딩플래너 진행 시,\n"),
                              TextSpan(text: "평균가는 "),
                              TextSpan(
                                text: "375,000원",
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(text: " 입니다"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 76,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("최저가"),
                                    SizedBox(height: 8),
                                    Text(
                                      "200,000원~",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 76,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("상담비 별도"),
                                    SizedBox(height: 8),
                                    Text(
                                      "30,000원",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, size: 18),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "실제 가격은 상담 후 계약에 따라 달라질 수 있습니다. 실제 가격은 상담 후 계약에 따라 달라질 수 있습니다.",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "전하고 싶은 말",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "저희 웨딩플래너는 최신 웨딩 트렌드와 정보를 항상 주시하고 있으며, 고객님의 개성과 취향을 반영한 맞춤형 웨딩 계획을 제안해 드립니다. 또한 신뢰할 수 있는 협력업체들과의 네트워크를 통해 최고의 서비스를 제공하고 있습니다.\n\n고객님의 소중한 웨딩을 위해 저희와 함께 행복한 결혼 생활의 시작을 준비해 보시기 바랍니다.",
                          style: TextStyle(fontSize: 15, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              10,
                              (index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const DetailsReviewTab(),
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
                    "상담하기",
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
