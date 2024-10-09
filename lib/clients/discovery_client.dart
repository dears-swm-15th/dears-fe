import 'package:dears/models/portfolio_overview.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'discovery_client.g.dart';

@RestApi(baseUrl: "v1/discovery")
abstract class DiscoveryClient {
  factory DiscoveryClient(Dio dio, {String baseUrl}) = _DiscoveryClient;

  @GET("/shared/recommend")
  Future<List<PortfolioOverview>> getRecommended();

  @GET("/shared/search")
  Future<List<PortfolioOverview>> search({
    @Query("content") String? content,
  });

  @GET("/shared/top5")
  Future<List<PortfolioOverview>> getTopViewed();
}
