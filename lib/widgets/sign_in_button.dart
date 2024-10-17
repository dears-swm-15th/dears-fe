import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/logger.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInButton extends ConsumerWidget {
  final OAuth2Provider provider;
  final BoxDecoration? decoration;
  final Widget prefix;
  final Widget title;

  const SignInButton({
    super.key,
    required this.provider,
    this.decoration,
    required this.prefix,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        try {
          await ref.read(authStateProvider.notifier).signIn(provider);

          if (!context.mounted) return;
          context.go("/");
        } on TokenIssuanceException catch (e, s) {
          logger.d("failed to sign in", error: e, stackTrace: s);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: decoration,
        child: Row(
          children: [
            prefix,
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
              ),
              child: title,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
