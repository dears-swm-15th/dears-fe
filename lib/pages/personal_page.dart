import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonalListTile(
            onTap: () {},
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            leading: const CircleAvatar(radius: 36),
            titleSpacing: 8,
            title: const Text(
              "닉네임",
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("example@gmail.com"),
            trailing: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 32, bottom: 16),
            child: Text(
              "내 활동",
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PersonalListTile(
            onTap: () {},
            title: const Text("플래너 매칭"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          PersonalListTile(
            onTap: () {},
            title: const Text("내가 쓴 리뷰"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 100, bottom: 16),
            child: Text(
              "환경설정",
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PersonalListTile(
            onTap: () {},
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("알림"),
          ),
          PersonalListTile(
            onTap: () {},
            leading: const Icon(Icons.chat),
            title: const Text("1:1 문의"),
          ),
        ],
      ),
    );
  }
}
