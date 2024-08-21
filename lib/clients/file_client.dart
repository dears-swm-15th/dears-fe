import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'file_client.g.dart';

final FileClient fileClient = FileClient(Dio());

@RestApi()
abstract class FileClient {
  factory FileClient(Dio dio, {String baseUrl}) = _FileClient;

  @PUT("{presignedUrl}")
  @MultiPart()
  Future<void> upload({
    @Path() String presignedUrl,
    @Part() File file,
  });
}
