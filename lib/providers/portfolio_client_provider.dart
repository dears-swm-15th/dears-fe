import 'package:dears/clients/portfolio_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_client_provider.g.dart';

@riverpod
Future<PortfolioClient> portfolioClient(PortfolioClientRef ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return PortfolioClient(dio);
}
