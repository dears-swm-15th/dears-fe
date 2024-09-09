import 'package:dears/models/member_role.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:dears/widgets/role_selection_button.dart';
import 'package:dears/widgets/role_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoleSelectionPage extends ConsumerWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  ImageIcon(
                    AssetImage("assets/logo.png"),
                    size: 100,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "안녕하세요",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "웨딩플래너를",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "\n찾고 계신가요?",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // 예비 신혼부부 버튼
                  RoleSelectionButton(
                    colorTitle: "예비 신혼부부",
                    normalTitle: "로 시작하기",
                    subtitle: "나에게 딱 맞는 웨딩플래너를 찾아보세요",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => RoleSelectionDialog(
                          colorTitle: "예비 신혼부부",
                          normalTitle: "로 시작할까요?",
                          onAcceptPressed: () {
                            ref.read(userInfoProvider.notifier).signUpWithRole(MemberRole.customer);
                            context.pop();
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  // 웨딩플래너 버튼
                  RoleSelectionButton(
                    colorTitle: "웨딩플래너",
                    normalTitle: "로 시작하기",
                    subtitle: "웨딩플래너 등록하고 고객을 만나보세요",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => RoleSelectionDialog(
                          colorTitle: "웨딩플래너",
                          normalTitle: "로 시작할까요?",
                          onAcceptPressed: () {
                            ref.read(userInfoProvider.notifier).signUpWithRole(MemberRole.weddingPlanner);
                            context.pop();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 83),
          ],
        ),
      ),
    );
  }
}
