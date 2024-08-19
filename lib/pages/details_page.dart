import 'package:dears/providers/portfolio_provider.dart';
import 'package:dears/widgets/details_bottom_bar.dart';
import 'package:dears/widgets/details_introduction_tab.dart';
import 'package:dears/widgets/details_review_tab.dart';
import 'package:dears/widgets/details_sliver_app_bar.dart';
import 'package:dears/widgets/details_sliver_tab_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final int portfolioId;

  const DetailsPage({
    super.key,
    required this.portfolioId,
  });

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage>
    with SingleTickerProviderStateMixin {
  final keys = [GlobalKey(), GlobalKey()];

  late final ScrollController scrollController;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(animateTab);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void animateTab() {
    final i = keys.lastIndexWhere((key) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        return false;
      }

      final offset = renderBox.localToGlobal(Offset.zero);
      final topPadding = MediaQuery.of(context).padding.top;
      return offset.dy <= topPadding + kToolbarHeight + 44;
    });

    if (i == -1) {
      return;
    }

    tabController.animateTo(i);
  }

  Future<void> scrollToIndex(int index) async {
    scrollController.removeListener(animateTab);

    final context = keys[index].currentContext;
    if (context == null) {
      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
    );
    scrollController.addListener(animateTab);
  }

  @override
  Widget build(BuildContext context) {
    final portfolio = ref
        .watch(portfolioProvider(widget.portfolioId))
        .whenOrNull(data: (data) => data);

    if (portfolio == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  DetailsSliverAppBar(portfolio),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: DetailsSliverTabBarDelegate(
                      controller: tabController,
                      onTap: scrollToIndex,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DetailsIntroductionTab(
                      portfolio,
                      key: keys[0],
                    ),
                  ),
                ];
              },
              body: DetailsReviewTab(
                key: keys[1],
                portfolioId: widget.portfolioId,
              ),
            ),
          ),
          const Divider(height: 0),
          DetailsBottomBar(portfolio),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
