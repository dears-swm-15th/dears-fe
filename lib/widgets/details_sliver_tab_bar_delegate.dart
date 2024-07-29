import 'package:flutter/material.dart';

const double _height = 44;

class DetailsSliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  final ValueChanged<int> onTap;

  const DetailsSliverTabBarDelegate({
    required this.controller,
    required this.onTap,
  });

  @override
  double get minExtent => _height;

  @override
  double get maxExtent => _height;

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
          Center(child: Text("소개")),
          Center(child: Text("리뷰")),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(DetailsSliverTabBarDelegate oldDelegate) => false;
}
