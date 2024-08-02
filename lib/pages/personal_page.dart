import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:dears/widgets/personal_profile_list_tile.dart';
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
          const PersonalProfileListTile(),
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
            trailing: const Icon(DearsIcons.caret_right),
          ),
          PersonalListTile(
            onTap: () {},
            title: const Text("내가 쓴 리뷰"),
            trailing: const Icon(DearsIcons.caret_right),
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
            leading: const Icon(DearsIcons.notifications),
            title: const Text("알림"),
          ),
          PersonalListTile(
            onTap: () {},
            leading: const Icon(DearsIcons.chat),
            title: const Text("1:1 문의"),
          ),
        ],
      ),
    );
  }
}
