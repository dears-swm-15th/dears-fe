import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

const double _indicatorWidth = 80;

class DetailsSliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  final ValueChanged<int> onTap;

  const DetailsSliverTabBarDelegate({
    required this.controller,
    required this.onTap,
  });

  @override
  double get minExtent => tabHeight;

  @override
  double get maxExtent => tabHeight;

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
        tabs: const [
          SizedBox(
            width: _indicatorWidth,
            child: Center(
              child: Text("소개"),
            ),
          ),
          SizedBox(
            width: _indicatorWidth,
            child: Center(
              child: Text("리뷰"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(DetailsSliverTabBarDelegate oldDelegate) => false;
}
