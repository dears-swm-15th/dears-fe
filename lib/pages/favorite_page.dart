import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioList = ref.watch(portfolioListProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: List.generate(
            portfolioList.length,
            (index) {
              final portfolio = portfolioList[index];
              return PortfolioListTile(portfolio);
            },
          ),
        ),
      ),
    );
  }
}
