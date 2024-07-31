import 'package:dears/providers/top_viewed_provider.dart';
import 'package:dears/widgets/best_portfolio_list_title.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeTopViewedList extends ConsumerWidget {
  const HomeTopViewedList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topViewed = ref.watch(topViewedProvider);

    return topViewed.maybeWhen(
      data: (data) {
        return Column(
          children: List.generate(data.length, (index) {
            final portfolio = data[index];
            return BestPortfolioListTitle(portfolio);
          }),
        );
      },
      orElse: () {
        return const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
