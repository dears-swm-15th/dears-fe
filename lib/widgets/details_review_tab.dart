import 'package:dears/widgets/review_list_tile.dart';
import 'package:flutter/material.dart';

class DetailsReviewTab extends StatelessWidget {
  const DetailsReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  "리뷰",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => const ReviewListTile(),
          ),
        ],
      ),
    );
  }
}
