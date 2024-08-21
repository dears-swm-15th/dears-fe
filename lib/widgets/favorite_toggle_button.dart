import 'package:dears/providers/is_wish_listed_provider.dart';
import 'package:dears/providers/wish_list_ids_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteToggleButton extends ConsumerStatefulWidget {
  final int portfolioId;

  const FavoriteToggleButton(
    this.portfolioId, {
    super.key,
  });

  @override
  ConsumerState<FavoriteToggleButton> createState() =>
      _FavoriteToggleButtonState();
}

class _FavoriteToggleButtonState extends ConsumerState<FavoriteToggleButton> {
  Future<void> toggle() async {
    await ref.read(wishListIdsProvider.notifier).toggle(widget.portfolioId);
  }

  @override
  Widget build(BuildContext context) {
    final isWishListed =
        ref.watch(isWishListedProvider(widget.portfolioId)).valueOrNull ??
            false;

    return IconButton(
      padding: const EdgeInsets.all(10),
      onPressed: toggle,
      isSelected: isWishListed,
      selectedIcon: const Icon(DearsIcons.favorite, color: red),
      icon: const Icon(DearsIcons.favorite_outline),
    );
  }
}
