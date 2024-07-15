import 'package:dears/widgets/favorite_tab.dart';
import 'package:dears/widgets/personal_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final index = useState(0);

    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => index.value = value,
        children: const [
          Center(child: Text("홈")),
          Center(child: Text("검색")),
          FavoriteTab(),
          PersonalTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index.value,
        onTap: (value) => pageController.jumpToPage(value),
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
