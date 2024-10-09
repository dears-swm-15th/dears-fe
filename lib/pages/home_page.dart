import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/home_banner.dart';
import 'package:dears/widgets/home_navigation_bar.dart';
import 'package:dears/widgets/home_top_viewed_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => context.push("/search"),
            icon: const Icon(DearsIcons.search),
          ),
        ],
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: const [
          HomeBanner(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("이번 주 주목할 웨딩플래너", style: titleLarge),
          ),
          SizedBox(height: 10),
          HomeTopViewedList(),
        ],
      ),
      bottomNavigationBar: const HomeNavigationBar(),
    );
  }
}
