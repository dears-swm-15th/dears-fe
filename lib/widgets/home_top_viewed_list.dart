import 'package:dears/providers/top_viewed_provider.dart';
import 'package:dears/widgets/home_top_viewed_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _tileHeight = 66;
const double _tileCount = 5;

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
            return SizedBox(
              height: _tileHeight,
              child: HomeTopViewedListTile(
                rank: index + 1,
                portfolio: portfolio,
              ),
            );
          }),
        );
      },
      orElse: () {
        return const SizedBox(
          height: _tileHeight * _tileCount,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
