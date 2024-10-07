import 'package:dears/models/portfolio.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_portfolio_provider.g.dart';

@riverpod
Future<Portfolio?> myPortfolio(MyPortfolioRef ref) async {
  final portfolioClient = await ref.watch(portfolioClientProvider.future);

  try {
    return await portfolioClient.getMine();
  } on DioException catch (e) {
    // if the planner has not registered a portfolio yet
    if (e.response?.statusCode == 409) {
      return null;
    }

    rethrow;
  }
}
