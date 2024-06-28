import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewKeywordChips extends HookWidget {
  const ReviewKeywordChips({super.key});

  @override
  Widget build(BuildContext context) {
    final typeIndex = useState(0);
    final type1 = useState(false);
    final type2 = useState(false);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          onSelected: (value) => typeIndex.value = 0,
          selected: typeIndex.value == 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Text("동행"),
        ),
        ChoiceChip(
          onSelected: (value) => typeIndex.value = 1,
          selected: typeIndex.value == 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Text("비동행"),
        ),
        ChoiceChip(
          onSelected: (value) => typeIndex.value = 2,
          selected: typeIndex.value == 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Text("동행/비동행"),
        ),
        FilterChip(
          onSelected: (value) => type1.value = value,
          selected: type1.value,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Text("예물"),
        ),
        FilterChip(
          onSelected: (value) => type2.value = value,
          selected: type2.value,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelPadding: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const Text("신혼여행"),
        ),
      ],
    );
  }
}
