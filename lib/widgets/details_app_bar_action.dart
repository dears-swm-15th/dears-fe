import 'package:dears/models/member_role.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:dears/widgets/portfolio_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsAppBarAction extends ConsumerWidget {
  final int portfolioId;

  const DetailsAppBarAction(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider).requireValue;

    return switch (role) {
      MemberRole.customer => FavoriteToggleButton(portfolioId),
      MemberRole.weddingPlanner => IconButton(
          onPressed: () =>
              showPortfolioDeleteDialog(context, ref, portfolioId: portfolioId),
          icon: const Icon(Icons.delete),
        ),
    };
  }
}
