import 'package:dears/providers/wishlist_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    final emptyWidget = Expanded(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "저장한 웨딩플래너가 없습니다",
              style: titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "마음에 드는 웨딩플래너를 저장해보세요",
              style: bodySmall.copyWith(color: gray600),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );

    final child = wishlist.when(
      data: (data) {
        if (data.isEmpty) {
          return emptyWidget;
        }

        return Expanded(
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return const Divider(
                height: 4,
                indent: 16,
                endIndent: 16,
              );
            },
            itemBuilder: (context, index) {
              final overview = data[index];
              return PortfolioListTile(overview);
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return emptyWidget;
      },
      loading: () {
        return const Expanded(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                CircularProgressIndicator(),
                Spacer(flex: 2),
              ],
            ),
          ),
        );
      },
    );

    final count = wishlist.maybeWhen(
      data: (data) => data.length,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("하트"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: RichText(
              text: TextSpan(
                style: titleSmall,
                children: [
                  const TextSpan(text: "전체 "),
                  TextSpan(
                    text: "$count",
                    style: titleSmall.copyWith(color: blue500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
