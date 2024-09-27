import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/logger.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    await ref
                        .read(authStateProvider.notifier)
                        .signIn(const GoogleOAuth2Provider());

                    if (!context.mounted) return;
                    context.go("/");
                  } catch (e, s) {
                    logger.d(
                      "failed to sign in with Google",
                      error: e,
                      stackTrace: s,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: gray600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/g-logo.png",
                        width: 18,
                      ),
                      const Spacer(),
                      const Text("Google로 로그인"),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  try {
                    await ref
                        .read(authStateProvider.notifier)
                        .signIn(const KakaoOAuth2Provider());

                    if (!context.mounted) return;
                    context.go("/");
                  } catch (e, s) {
                    logger.d(
                      "failed to sign in with Kakao",
                      error: e,
                      stackTrace: s,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/kakao_symbol.png",
                        width: 18,
                      ),
                      const Spacer(),
                      const Text("카카오로 로그인"),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
