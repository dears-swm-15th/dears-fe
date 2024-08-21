import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const List<String> _reviewKeywords = [
  "동행",
  "비동행",
  "예물",
  "신혼여행",
  "혼수",
  "웨딩홀",
];

class ReviewKeywordChips extends HookWidget {
  const ReviewKeywordChips({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndexes =
        useState(List.filled(_reviewKeywords.length, false));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_reviewKeywords.length, (index) {
        final isSelected = selectedIndexes.value[index];

        return FilterChip(
          selected: isSelected,
          onSelected: (value) {
            selectedIndexes.value[index] = value;
            selectedIndexes.value = [...selectedIndexes.value];
          },
          side: BorderSide(color: isSelected ? blue500 : gray100),
          checkmarkColor: blue500,
          label: Text(
            _reviewKeywords[index],
            style: TextStyle(color: isSelected ? blue500 : gray600),
          ),
        );
      }),
    );
  }
}
