import 'package:dears/models/review_create_body.dart';
import 'package:dears/models/review_create_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'review_client.g.dart';

@RestApi(baseUrl: "v1/review")
abstract class ReviewClient {
  factory ReviewClient(Dio dio, {String baseUrl}) = _ReviewClient;

  @POST("/{role}/create")
  Future<ReviewCreateResponse> create({
    @Body() required ReviewCreateBody data,
  });
}
