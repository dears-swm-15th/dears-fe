import 'package:dears/models/review.dart';
import 'package:dears/models/review_create_body.dart';
import 'package:dears/models/review_create_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'review_client.g.dart';

@RestApi(baseUrl: "v1/review")
abstract class ReviewClient {
  factory ReviewClient(Dio dio, {String baseUrl}) = _ReviewClient;

  @GET("/shared/{id}")
  Future<Review> getById(@Path() int id);

  @GET("/shared/all")
  Future<List<Review>> getAll();

  @GET("/shared/soft-deleted")
  Future<List<Review>> getAllSoftDeleted();

  @POST("/{role}/create")
  Future<ReviewCreateResponse> create({
    @Body() required ReviewCreateBody data,
  });

  @POST("/{role}/delete/{id}")
  Future<void> delete(@Path() int id);

  @GET("/{role}/me")
  Future<List<Review>> getAllMine();

  @POST("/{role}/update/{id}")
  Future<Review> update(
    @Path() int id, {
    @Body() required Review data,
  });
}
