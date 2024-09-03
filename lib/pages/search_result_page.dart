import 'package:dears/providers/search_result_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/list_status_widget.dart';
import 'package:dears/widgets/portfolio_list_tile.dart';
import 'package:dears/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchResultPage extends ConsumerWidget {
  final String query;

  const SearchResultPage({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchResultProvider(query));

    const emptyWidget = EmptyListWidget(
      title: "검색 결과가 없습니다",
      subtitle: "다른 검색어로 검색해보세요",
    );

    final count = searchResult.maybeWhen(
      data: (data) => data.length,
      orElse: () => 0,
    );

    final result = searchResult.when(
      data: (data) {
        if (data.isEmpty) {
          return emptyWidget;
        }

        return Expanded(
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return const Divider(height: 4, indent: 16, endIndent: 16);
            },
            itemBuilder: (context, index) {
              final overview = data[index];
              return PortfolioListTile(overview);
            },
          ),
        );
      },
      error: (error, stackTrace) => emptyWidget,
      loading: () => const LoadingListWidget(),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 4, right: 8),
          child: SearchTextField(
            text: query,
            onSubmitted: (value) => context.pushReplacement("/search?q=$value"),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: titleSmall,
                children: [
                  const TextSpan(text: "검색결과 "),
                  TextSpan(
                    text: "$count",
                    style: const TextStyle(color: blue500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          result,
        ],
      ),
    );
  }
}
