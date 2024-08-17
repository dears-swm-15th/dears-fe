import 'package:dears/models/portfolio.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_provider.g.dart';

@riverpod
Future<Portfolio> portfolio(PortfolioRef ref, int id) async {
  final portfolioClient = await ref.watch(portfolioClientProvider.future);
  return portfolioClient.getById(id);
}
