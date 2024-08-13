import 'package:dears/utils/hooks.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../providers/wishlist_provider.dart';

class FavoriteToggleButton extends HookConsumerWidget {
  final bool initialFavorite;
  final int portfolioId;
  const FavoriteToggleButton({
    super.key,
    required this.initialFavorite,
    required this.portfolioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (isFavorite, toggleFavorite) = useToggle(initialFavorite);
    final wishlist = ref.read(wishlistProvider.notifier);

    Future<void> handleToggle() async {
      if (isFavorite) {
        await wishlist.removeFromWishList(portfolioId);
      } else {
        await wishlist.addToWishList(portfolioId);
      }
      toggleFavorite();
    }

    return IconButton(
      padding: const EdgeInsets.all(10),
      onPressed: handleToggle,
      isSelected: isFavorite,
      selectedIcon: const Icon(DearsIcons.favorite, color: red),
      icon: const Icon(DearsIcons.favorite_outline),
    );
  }
}
