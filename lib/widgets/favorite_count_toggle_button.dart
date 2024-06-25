import 'package:dears/utils/hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoriteCountToggleButton extends HookWidget {
  final bool initialFavorite;
  final int initialCount;

  const FavoriteCountToggleButton({
    super.key,
    required this.initialFavorite,
    required this.initialCount,
  });

  @override
  Widget build(BuildContext context) {
    final (isFavorite, count, toggleFavorite) = useCountToggle(
      initialState: initialFavorite,
      initialCount: initialCount,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: toggleFavorite,
          isSelected: isFavorite,
          selectedIcon: const Icon(Icons.favorite),
          icon: const Icon(Icons.favorite_border),
        ),
        Text("$count"),
      ],
    );
  }
}
