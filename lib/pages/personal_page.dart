import 'package:dears/providers/auth_state_provider.dart';
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
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("고객센터", style: titleMedium),
          ),
          const SizedBox(height: 16),
          PersonalListTile(
            title: "문의하기",
            onTap: () => context.push("/inquiry"),
          ),
          PersonalListTile(
            title: "서비스 이용약관",
            onTap: () {},
          ),
          PersonalListTile(
            title: "개인정보 처리 방침",
            onTap: () {},
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
