import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_viewed_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> topViewed(TopViewedRef ref) async {
  final portfolioClient = await ref.watch(portfolioClientProvider.future);
  return portfolioClient.getTopViewed();
}
