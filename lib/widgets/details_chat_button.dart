import 'package:dears/models/member_role.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsChatButton extends ConsumerWidget {
  final int portfolioId;

  const DetailsChatButton(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).requireValue;

    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: role == MemberRole.customer
          ? () => context.push("/chats/redirect/$portfolioId")
          : null,
      child: const Text("상담하기"),
    );
  }
}
