import 'package:dears/utils/hooks.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoriteToggleButton extends HookWidget {
  final bool initialFavorite;

  const FavoriteToggleButton({
    super.key,
    required this.initialFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final (isFavorite, toggleFavorite) = useToggle(initialFavorite);

    return IconButton(
      padding: const EdgeInsets.all(10),
      onPressed: toggleFavorite,
      isSelected: isFavorite,
      selectedIcon: const Icon(DearsIcons.favorite, color: red),
      icon: const Icon(DearsIcons.favorite_outline),
    );
  }
}
