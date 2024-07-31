import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/models/portfolio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_provider.g.dart';

@riverpod
Future<Portfolio> portfolio(PortfolioRef ref, int id) {
  return portfolioClient.getById(id);
}
