import 'package:dears/models/review_type.dart';
import 'package:dears/providers/review_list_provider.dart';
import 'package:dears/widgets/review_input.dart';
import 'package:dears/widgets/review_list_tile.dart';
import 'package:dears/widgets/review_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsReviewTab extends HookConsumerWidget {
  final int portfolioId;

  const DetailsReviewTab({
    super.key,
    required this.portfolioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewList = ref.watch(reviewListProvider(portfolioId));

    final tiles = reviewList.maybeWhen(
      data: (data) {
        return SliverList.separated(
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final review = data[index];
            return ReviewListTile(review);
          },
        );
      },
      orElse: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    final count = reviewList.maybeWhen(
      data: (data) => data.length,
      orElse: () => 0,
    );

    final reviewType = useState(ReviewType.values[0]);

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
                            text: "$count",
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
          tiles,
        ],
      ),
    );
  }
}
