import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/models/portfolio_overview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_viewed_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> topViewed(TopViewedRef ref) {
  return portfolioClient.getTopViewed();
}
