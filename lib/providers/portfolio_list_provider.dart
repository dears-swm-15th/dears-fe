import 'package:dears/models/portfolio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_list_provider.g.dart';

@riverpod
List<Portfolio> portfolioList(PortfolioListRef ref) {
  return [];
}
