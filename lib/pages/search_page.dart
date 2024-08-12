import 'package:dears/providers/recent_search_words_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/list_status_widget.dart';
import 'package:dears/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearchWords = ref.watch(recentSearchWordsProvider);

    const emptyWidget = EmptyListWidget(
      title: "최근 검색어가 없습니다",
      subtitle: "웨딩 관련 키워드를 검색해보세요",
    );

    final chips = recentSearchWords.when(
      data: (data) {
        if (data.isEmpty) {
          return emptyWidget;
        }

        return Expanded(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(data.length, (index) {
              final label = data[index];
              return FilterChip(
                onSelected: (value) => context.push("/search?q=$label"),
                onDeleted: () => ref
                    .read(recentSearchWordsProvider.notifier)
                    .removeAt(index),
                deleteIcon: const Icon(DearsIcons.close, size: 16),
                label: Text(label),
              );
            }),
          ),
        );
      },
      error: (error, stackTrace) => emptyWidget,
      loading: () => const LoadingListWidget(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SearchTextField(
            onSubmitted: (value) => context.push("/search?q=$value"),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("최근 검색어", style: titleMedium),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    fixedSize: const Size.fromHeight(24),
                  ),
                  onPressed: () =>
                      ref.read(recentSearchWordsProvider.notifier).clear(),
                  child: Text(
                    "전체 삭제",
                    style: bodySmall.copyWith(color: gray600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            chips,
          ],
        ),
      ),
    );
  }
}
