import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/models/portfolio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_list_provider.g.dart';

@riverpod
Future<List<Portfolio>> portfolioList(PortfolioListRef ref) {
  return portfolioClient.getAll();
}
