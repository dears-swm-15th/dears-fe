import 'package:dears/models/member_role.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showRoleSelectionDialog(
  BuildContext context, {
  required MemberRole role,
  required Future<void> Function(MemberRole role) fix,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                DearsIcons.info,
                size: 50,
                color: blue100,
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: titleLarge,
                  children: [
                    TextSpan(
                      text: role.label,
                      style: const TextStyle(color: blue500),
                    ),
                    const TextSpan(text: "로 시작할까요?"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "한 번 설정된 역할은 변경할 수 없습니다",
                style: TextStyle(color: gray600),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: gray100,
                        foregroundColor: gray800,
                      ),
                      child: const Text("취소"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        await fix(role);

                        if (!context.mounted) return;
                        context.go("/sign-in");
                      },
                      child: const Text("네, 좋아요"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
