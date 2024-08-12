import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/recent_search_words_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> searchResult(
  SearchResultRef ref,
  String query,
) {
  ref.read(recentSearchWordsProvider.notifier).add(query);

  return portfolioClient.search(content: query);
}
