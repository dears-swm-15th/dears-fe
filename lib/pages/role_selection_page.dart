import 'package:dears/models/member_role.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/role_selection_button.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8),
            const Text(
              "안녕하세요",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: black, fontSize: 28),
                children: [
                  TextSpan(
                    text: "웨딩플래너를\n",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: "찾고 계신가요?"),
                ],
              ),
            ),
            const Spacer(),
            const RoleSelectionButton(
              role: MemberRole.customer,
              subtitle: "나에게 딱 맞는 웨딩플래너를 찾아보세요",
            ),
            const SizedBox(height: 10),
            const RoleSelectionButton(
              role: MemberRole.weddingPlanner,
              subtitle: "웨딩플래너 등록하고 고객을 만나보세요",
            ),
          ],
        ),
      ),
    );
  }
}
