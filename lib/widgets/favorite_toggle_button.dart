import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoriteToggleButton extends HookWidget {
  final bool initialFavorite;
  final int initialCount;

  const FavoriteToggleButton({
    super.key,
    required this.initialFavorite,
    required this.initialCount,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = useState(initialFavorite);
    final count = useState(initialCount);

    final toggleFavorite = useCallback(() {
      isFavorite.value = !isFavorite.value;
      isFavorite.value ? count.value++ : count.value--;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: toggleFavorite,
          isSelected: isFavorite.value,
          selectedIcon: const Icon(Icons.favorite),
          icon: const Icon(Icons.favorite_border),
        ),
        Text("${count.value}"),
      ],
    );
  }
}
