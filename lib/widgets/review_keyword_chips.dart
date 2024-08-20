import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const List<List<String>> _keywordGroups = [
  ["동행", "비동행"],
  ["예물"],
  ["신혼여행"],
  ["혼수"],
  ["웨딩홀"],
];

class ReviewKeywordChips extends HookWidget {
  const ReviewKeywordChips({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndexes = useState(List.filled(_keywordGroups.length, 0));

    final onSelected = useCallback((int groupIndex, int keywordIndex) {
      selectedIndexes.value[groupIndex] = keywordIndex;
      selectedIndexes.value = [...selectedIndexes.value];
    });

    final selected = useCallback((int groupIndex, int keywordIndex) {
      return selectedIndexes.value[groupIndex] == keywordIndex;
    });

    final children = useCallback(() sync* {
      for (final (i, group) in _keywordGroups.indexed) {
        if (group.isEmpty) {
          continue;
        }

        if (group.length == 1) {
          yield FilterChip(
            onSelected: (value) => onSelected(i, value ? 1 : 0),
            selected: selected(i, 1),
            label: Text(group[0]),
          );

          continue;
        }

        for (final (j, keyword) in group.indexed) {
          yield ChoiceChip(
            onSelected: (value) => onSelected(i, j),
            selected: selected(i, j),
            label: Text(keyword),
          );
        }
      }
    });

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [...children()],
    );
  }
}
