import 'package:dears/models/review_form_data.dart';
import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewKeywordChips extends ConsumerWidget {
  final int portfolioId;

  const ReviewKeywordChips(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.tags),
    );

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(reviewKeywords.length, (index) {
        final selected = tags[index];

        return FilterChip(
          selected: selected,
          onSelected: (value) => ref
              .read(reviewFormProvider(portfolioId).notifier)
              .setTags([...tags]..[index] = value),
          side: BorderSide(color: selected ? blue500 : gray100),
          checkmarkColor: blue500,
          label: Text(
            reviewKeywords[index],
            style: TextStyle(color: selected ? blue500 : gray600),
          ),
        );
      }),
    );
  }
}
