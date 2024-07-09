import 'package:dears/widgets/review_input.dart';
import 'package:dears/widgets/review_list_tile.dart';
import 'package:flutter/material.dart';

const int _reviewCount = 3;

class DetailsReviewTab extends StatelessWidget {
  const DetailsReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReviewInput(),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: "리뷰 "),
                      TextSpan(
                        text: "$_reviewCount",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: _reviewCount,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => const ReviewListTile(),
          ),
        ],
      ),
    );
  }
}
