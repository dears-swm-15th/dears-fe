import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:dears/widgets/personal_profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalPage extends ConsumerWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("마이페이지"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PersonalProfileListTile(),
          const Divider(
            height: 4,
            thickness: 4,
            color: gray100,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 13, top: 16, bottom: 10),
            child: Text(
              "내 활동",
              style: TextStyle(
                color: gray600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          PersonalListTile(
            onTap: () {},
            title: const Text("내가 쓴 리뷰"),
            leading: const Icon(DearsIcons.chat),
            trailing: const Icon(DearsIcons.caret_right),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 13, top: 20, bottom: 10),
            child: Text(
              "고객센터",
              style: TextStyle(
                color: gray600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          PersonalListTile(
            onTap: () {
              context.push("/inquiry");
            },
            leading: const Icon(DearsIcons.chat),
            title: const Text("문의하기"),
            trailing: const Icon(DearsIcons.caret_right),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).signOut();
            },
            child: Text(
              "로그아웃",
              style: bodySmall.copyWith(
                color: gray600,
                decoration: TextDecoration.underline,
                decorationColor: gray600,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
