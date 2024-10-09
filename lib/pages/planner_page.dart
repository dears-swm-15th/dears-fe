import 'package:dears/providers/my_portfolio_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/planner_navigation_bar.dart';
import 'package:dears/widgets/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerPage extends ConsumerWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(myPortfolioProvider).valueOrNull;

    final name = portfolio?.name ?? "";
    final radar = portfolio?.avgRadar ?? {};

    return Scaffold(
      appBar: CustomAppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.asset(
            "assets/logo.png",
            width: toolbarHeight,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(DearsIcons.notifications),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20),
          Text("안녕하세요\n$name 웨딩플래너님", style: titleMedium),
          const SizedBox(height: 52),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("나의 평가", style: titleMedium),
                const SizedBox(height: 4),
                Text(
                  "추가 설명",
                  style: titleSmall.copyWith(color: gray600),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: RadarChart(radar),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("조회수", style: titleMedium),
                const SizedBox(height: 4),
                Text(
                  "추가 설명",
                  style: titleSmall.copyWith(color: gray600),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PlannerNavigationBar(),
    );
  }
}
