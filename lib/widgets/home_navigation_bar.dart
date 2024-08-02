import 'package:dears/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            context.push("/search");
          case 1:
            context.push("/favorite");
          case 2:
            context.push("/chats");
          case 3:
            context.push("/personal");
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(DearsIcons.search),
          label: "검색",
        ),
        BottomNavigationBarItem(
          icon: Icon(DearsIcons.favorite_outline),
          label: "하트",
        ),
        BottomNavigationBarItem(
          icon: Icon(DearsIcons.chat),
          label: "채팅",
        ),
        BottomNavigationBarItem(
          icon: Icon(DearsIcons.person),
          label: "마이페이지",
        ),
      ],
    );
  }
}
