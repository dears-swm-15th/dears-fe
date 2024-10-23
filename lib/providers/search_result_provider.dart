import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/discovery_client_provider.dart';
import 'package:dears/providers/recent_search_words_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> searchResult(Ref ref, String query) async {
  if (query.isNotEmpty) {
    ref.read(recentSearchWordsProvider.notifier).add(query);
  }

  final discoveryClient = await ref.watch(discoveryClientProvider.future);
  return discoveryClient.search(content: query);
}
