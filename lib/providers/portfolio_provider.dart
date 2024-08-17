import 'package:dears/models/portfolio.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_provider.g.dart';

@riverpod
Future<Portfolio> portfolio(PortfolioRef ref, int id) {
  final portfolioClient = ref.watch(portfolioClientProvider);
  return portfolioClient.getById(id);
}
