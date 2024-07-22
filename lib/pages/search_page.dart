import 'package:dears/providers/recent_search_words_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearchWords = ref.watch(recentSearchWordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(right: 16),
          height: 42,
          child: TextField(
            onSubmitted: (value) =>
                ref.read(recentSearchWordsProvider.notifier).add(value),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            style: const TextStyle(color: black, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: "검색어를 입력하세요",
              hintStyle: TextStyle(color: gray600),
              prefixIcon: Icon(Icons.search, color: gray600),
              suffixIcon: Icon(Icons.cancel, size: 16, color: gray600),
              filled: true,
              fillColor: blue50,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "최근 검색어",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        fixedSize: const Size.fromHeight(24),
                      ),
                      onPressed: () =>
                          ref.read(recentSearchWordsProvider.notifier).clear(),
                      child: const Text(
                        "전체 삭제",
                        style: TextStyle(
                          color: gray600,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (recentSearchWords.isEmpty)
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 180),
                        Text(
                          "최근 검색어가 없습니다",
                          style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "웨딩 관련 키워드를 검색해보세요",
                          style: TextStyle(
                            color: gray600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      recentSearchWords.length,
                      (index) {
                        return FilterChip(
                          onSelected: (value) {},
                          onDeleted: () => ref
                              .read(recentSearchWordsProvider.notifier)
                              .removeAt(index),
                          deleteIcon: const Icon(Icons.clear, size: 16),
                          label: Text(recentSearchWords[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
