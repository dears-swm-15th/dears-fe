import 'package:dears/models/review_type.dart';
import 'package:dears/providers/review_list_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/review_list_tile.dart';
import 'package:dears/widgets/review_type_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
        if (data.isEmpty) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: gray100),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("리뷰가 없습니다", style: titleMedium),
                const SizedBox(height: 8),
                Text(
                  "첫 리뷰를 남겨주세요",
                  style: bodySmall.copyWith(color: gray600),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final review = data[index];
            return ReviewListTile(review);
          },
        );
      },
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final count = reviewList.maybeWhen(
      data: (data) => data.length,
      orElse: () => 0,
    );

    final reviewType = useState(ReviewType.consulting);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
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
                value: reviewType.value,
                onChanged: (value) => reviewType.value = value,
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(
              fixedSize: const Size.fromHeight(44),
            ),
            onPressed: () {
              final location = "/details/$portfolioId";
              context.push("$location/review/edit");
            },
            child: const Text("리뷰 작성하러 가기"),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: titleMedium,
              children: [
                TextSpan(text: "${reviewType.value} 리뷰 "),
                TextSpan(
                  text: "$count",
                  style: const TextStyle(color: blue500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          tiles,
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
