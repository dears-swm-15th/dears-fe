import 'package:dears/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlannerNavigationBar extends StatelessWidget {
  final int portfolioId;

  const PlannerNavigationBar({
    super.key,
    required this.portfolioId,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            context.push("/details/$portfolioId");
          case 1:
            ; // not implemented
          case 2:
            context.push("/chats");
          case 3:
            context.push("/personal");
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_outlined),
          label: "포트폴리오",
        ),
        BottomNavigationBarItem(
          icon: Icon(DearsIcons.close),
          label: "칼럼",
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
