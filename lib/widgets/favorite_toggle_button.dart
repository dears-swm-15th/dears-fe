import 'package:dears/utils/hooks.dart';
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
      onPressed: toggleFavorite,
      isSelected: isFavorite,
      selectedIcon: const Icon(Icons.favorite),
      icon: const Icon(Icons.favorite_border),
    );
  }
}
