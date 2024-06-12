import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'portfolio_client.g.dart';

@RestApi()
abstract class PortfolioClient {
  factory PortfolioClient(Dio dio, {String baseUrl}) = _PortfolioClient;
}
