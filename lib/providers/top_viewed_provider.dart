import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/discovery_client_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_viewed_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> topViewed(Ref ref) async {
  final discoveryClient = await ref.watch(discoveryClientProvider.future);
  return discoveryClient.getTopViewed();
}
