import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showWithdrawDialog(BuildContext context, WidgetRef ref) async {
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
              const Text(
                "정말로 회원탈퇴 하시겠습니까?",
                style: titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                "회원정보는 모두 삭제됩니다",
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
                        await ref.read(authStateProvider.notifier).withdraw();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: red,
                      ),
                      child: const Text("회원탈퇴"),
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
