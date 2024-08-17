import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_client_provider.g.dart';

@riverpod
PortfolioClient portfolioClient(PortfolioClientRef ref) {
  final dio = ref.watch(apiDioProvider);
  return PortfolioClient(dio);
}
