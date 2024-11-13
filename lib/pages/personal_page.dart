import 'package:dears/models/member_role.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/personal_list_tile.dart';
import 'package:dears/widgets/personal_profile_list_tile.dart';
import 'package:dears/widgets/recent_seen_portfolio_list.dart';
import 'package:dears/widgets/sign_out_dialog.dart';
import 'package:dears/widgets/withdraw_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PersonalPage extends ConsumerWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).requireValue;

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
          if (role == MemberRole.customer) ...[
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("최근 본 포트폴리오", style: titleMedium),
            ),
            const SizedBox(height: 16),
            const RecentSeenPortfolioList(),
            const SizedBox(height: 30),
            const Divider(
              height: 4,
              thickness: 4,
              color: gray100,
            ),
          ],
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("고객센터", style: titleMedium),
          ),
          const SizedBox(height: 16),
          PersonalListTile(
            title: "문의/신고하기",
            onTap: () => context.push("/inquiry"),
          ),
          PersonalListTile(
            title: "서비스 이용약관",
            onTap: () => launchUrlString(termsOfServiceUrl),
          ),
          PersonalListTile(
            title: "개인정보 처리 방침",
            onTap: () => launchUrlString(privacyPolicyUrl),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => showSignOutDialog(context, ref),
            child: Text(
              "로그아웃",
              style: bodySmall.copyWith(
                color: gray600,
                decoration: TextDecoration.underline,
                decorationColor: gray600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => showWithdrawDialog(context, ref),
            child: Text(
              "회원탈퇴",
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
