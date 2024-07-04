import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:dears/widgets/personal_tab.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioList = ref.watch(portfolioListProvider);

    final pageController = usePageController();
    final index = useState(0);

    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => index.value = value,
        children: [
          const Center(child: Text("홈")),
          const Center(child: Text("검색")),
          Center(
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
          const PersonalTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index.value,
        onTap: (value) => pageController.jumpToPage(value),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "검색",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "하트",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "내 정보",
          ),
        ],
      ),
    );
  }
}
