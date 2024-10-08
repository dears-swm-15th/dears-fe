import 'package:dears/providers/wishlist_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/list_status_widget.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  void initState() {
    super.initState();

    // Invalidate the `wishlistProvider` when the page is opened.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.invalidate(wishlistProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mark the `wishlist` as loading when the page is opened.
    final wishlist = ref.watch(wishlistProvider).unwrapPrevious();

    const emptyWidget = EmptyListWidget(
      title: "저장한 웨딩플래너가 없습니다",
      subtitle: "마음에 드는 웨딩플래너를 저장해보세요",
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
              return const Divider(height: 4, indent: 16, endIndent: 16);
            },
            itemBuilder: (context, index) {
              final overview = data[index];
              return PortfolioListTile(overview);
            },
          ),
        );
      },
      error: (error, stackTrace) => emptyWidget,
      loading: () => const LoadingListWidget(),
    );

    final count = wishlist.maybeWhen(
      data: (data) => data.length,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("하트"),
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
