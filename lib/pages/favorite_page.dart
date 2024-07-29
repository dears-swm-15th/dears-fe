import 'package:dears/providers/wishlist_provider.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    final body = wishlist.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text("Error: $error"),
        );
      },
      data: (data) {
        return Center(
          child: ListView(
            children: List.generate(
              data.length,
              (index) {
                final overview = data[index];
                return PortfolioListTile(overview);
              },
            ),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
  }
}
