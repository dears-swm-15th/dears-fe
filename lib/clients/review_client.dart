import 'package:dears/models/review.dart';
import 'package:dears/utils/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'review_client.g.dart';

final ReviewClient reviewClient = ReviewClient(dio);

@RestApi(baseUrl: "v1/review")
abstract class ReviewClient {
  factory ReviewClient(Dio dio, {String baseUrl}) = _ReviewClient;

  @GET("/shared/{id}")
  Future<Review> getById(@Path() int id);

  @GET("/shared/all")
  Future<List<Review>> getAll();

  @GET("/shared/soft-deleted")
  Future<List<Review>> getAllSoftDeleted();

  @POST("/customer/create")
  Future<Review> create({
    @Body() required Review data,
  });

  @POST("/customer/delete/{id}")
  Future<void> delete(@Path() int id);

  @GET("/customer/me")
  Future<List<Review>> getAllMine();

  @POST("/customer/update/{id}")
  Future<Review> update(
    @Path() int id, {
    @Body() required Review data,
  });
}
