import 'package:dears/models/member_role.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsReviewEditButton extends ConsumerWidget {
  final int portfolioId;

  const DetailsReviewEditButton(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).requireValue;

    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: const Size.fromHeight(44),
      ),
      onPressed: role == MemberRole.customer
          ? () => context.push("/details/$portfolioId/review/edit")
          : null,
      child: const Text("리뷰 작성하러 가기"),
    );
  }
}
