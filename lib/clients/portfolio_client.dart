import 'package:dears/models/portfolio.dart';
import 'package:dears/models/portfolio_create_body.dart';
import 'package:dears/models/portfolio_create_response.dart';
import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/models/review.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'portfolio_client.g.dart';

@RestApi(baseUrl: "v1/portfolio")
abstract class PortfolioClient {
  factory PortfolioClient(Dio dio, {String baseUrl}) = _PortfolioClient;

  @GET("/shared/{id}")
  Future<Portfolio> getById(@Path() int id);

  @GET("/shared/all")
  Future<List<Portfolio>> getAll();

  @GET("/shared/reviews/{id}")
  Future<List<Review>> getAllReviews(@Path() int id);

  @GET("/shared/search")
  Future<List<PortfolioOverview>> search({
    @Query("content") String? content,
  });

  @GET("/shared/soft-deleted")
  Future<List<Portfolio>> getAllSoftDeleted();

  @GET("/shared/top5")
  Future<List<PortfolioOverview>> getTopViewed();

  @POST("/{role}/create")
  Future<PortfolioCreateResponse> create({
    @Body() required PortfolioCreateBody body,
  });

  @POST("/{role}/delete/{id}")
  Future<void> delete(@Path() int id);

  @GET("/{role}/me")
  Future<Portfolio> getMine();

  @POST("/{role}/update/{id}")
  Future<Portfolio> update(
    @Path() int id, {
    @Body() required Portfolio body,
  });
}
