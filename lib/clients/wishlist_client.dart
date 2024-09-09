import 'package:dears/models/portfolio_overview.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'wishlist_client.g.dart';

@RestApi(baseUrl: "v1/wishlist")
abstract class WishlistClient {
  factory WishlistClient(Dio dio, {String baseUrl}) = _WishlistClient;

  @POST("/{role}/delete/{portfolioId}")
  Future<void> delete(@Path() int portfolioId);

  @GET("/{role}/me")
  Future<List<PortfolioOverview>> getAll({
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @POST("/{role}/post/{portfolioId}")
  Future<void> add(@Path() int portfolioId);
}
