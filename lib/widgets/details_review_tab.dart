import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/providers/review_list_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/review_input.dart';
import 'package:dears/widgets/review_list_tile.dart';
import 'package:dears/widgets/review_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsReviewTab extends ConsumerWidget {
  final int portfolioId;

  const DetailsReviewTab({
    super.key,
    required this.portfolioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewType = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.type),
    );

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList.list(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: titleLarge,
                      children: [
                        const TextSpan(text: "리뷰 "),
                        TextSpan(
                          text: "$count",
                          style: const TextStyle(color: blue500),
                        ),
                      ],
                    ),
                  ),
                  ReviewTypeSwitch(
                    value: reviewType,
                    onChanged: (value) => ref
                        .read(reviewFormProvider(portfolioId).notifier)
                        .setType(value),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ReviewInput(portfolioId),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: titleMedium,
                  children: [
                    TextSpan(text: "$reviewType 리뷰 "),
                    TextSpan(
                      text: "$count",
                      style: const TextStyle(color: blue500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          tiles,
        ],
      ),
    );
  }
}
