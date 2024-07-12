import 'package:dears/models/review_type.dart';
import 'package:dears/widgets/review_input.dart';
import 'package:dears/widgets/review_list_tile.dart';
import 'package:dears/widgets/review_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const List<int> _reviewCounts = [3, 7];
final int _totalReviewCount = _reviewCounts.reduce((a, b) => a + b);

class DetailsReviewTab extends HookWidget {
  const DetailsReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewType = useState(ReviewType.values[0]);
    final count = _reviewCounts[reviewType.value.index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: "리뷰 "),
                          TextSpan(
                            text: "$_totalReviewCount",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    ReviewTypeSwitch(
                      value: reviewType.value,
                      onChanged: (value) => reviewType.value = value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ReviewInput(type: reviewType.value),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: "${reviewType.value} 리뷰 "),
                      TextSpan(
                        text: "$count",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: count,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) => const ReviewListTile(),
          ),
        ],
      ),
    );
  }
}
