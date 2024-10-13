import 'package:dears/providers/top_viewed_provider.dart';
import 'package:dears/widgets/list_status_widget.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentSeenPortfolioList extends ConsumerWidget {
  const RecentSeenPortfolioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: replace provider to one of recent seen portfolios
    final recentSeen = ref.watch(topViewedProvider);

    const emptyWidget = EmptyListWidget(
      title: "최근 본 포트폴리오가 없습니다",
      subtitle: "마음에 드는 포트폴리오를 찾아보세요",
    );

    final child = recentSeen.when(
      data: (data) {
        if (data.isEmpty) {
          return emptyWidget;
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            final portfolio = data[index];
            return PortfolioListTile(portfolio, compact: true);
          },
        );
      },
      error: (error, stackTrace) => emptyWidget,
      loading: () => const LoadingListWidget(),
    );

    return SizedBox(
      height: 84,
      child: child,
    );
  }
}
