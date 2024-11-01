import 'package:dears/models/portfolio.dart';
import 'package:dears/models/portfolio_create_body.dart';
import 'package:dears/models/portfolio_create_response.dart';
import 'package:dears/models/review.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'portfolio_client.g.dart';

@RestApi(baseUrl: "v1/portfolio")
abstract class PortfolioClient {
  factory PortfolioClient(Dio dio, {String baseUrl}) = _PortfolioClient;

  @GET("/shared/{id}")
  Future<Portfolio> getById(@Path() int id);

  @GET("/shared/reviews/{id}")
  Future<List<Review>> getAllReviews(@Path() int id);

  @POST("/{role}/create")
  Future<PortfolioCreateResponse> create({
    @Body() required PortfolioCreateBody data,
  });

  @GET("/{role}/me")
  Future<Portfolio> getMine();
}
