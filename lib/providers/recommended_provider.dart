import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/discovery_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recommended_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> recommended(RecommendedRef ref) async {
  final discoveryClient = await ref.watch(discoveryClientProvider.future);
  return discoveryClient.getRecommended();
}
