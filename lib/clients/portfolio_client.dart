import 'package:dears/models/portfolio.dart';
import 'package:dears/models/portfolio_search_response.dart';
import 'package:dears/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'portfolio_client.g.dart';

final PortfolioClient portfolioClient = PortfolioClient(dio);

@RestApi(baseUrl: "v1/portfolio")
abstract class PortfolioClient {
  factory PortfolioClient(Dio dio, {String baseUrl}) = _PortfolioClient;

  @GET("/shared/{id}")
  Future<Portfolio> getById(@Path() int id);

  @GET("/shared/all")
  Future<List<Portfolio>> getAll();

  @GET("/shared/search")
  Future<List<PortfolioSearchResponse>> search({
    @Query("content") String? content,
  });

  @GET("/shared/soft-deleted")
  Future<List<Portfolio>> getAllSoftDeleted();

  @POST("/weddingplanner/create")
  Future<Portfolio> create({
    @Body() required Portfolio body,
  });

  @POST("/weddingplanner/delete/{id}")
  Future<void> delete(@Path() int id);

  @POST("/weddingplanner/update/{id}")
  Future<Portfolio> update(
    @Path() int id, {
    @Body() required Portfolio body,
  });
}
