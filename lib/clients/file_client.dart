import 'dart:typed_data';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'file_client.g.dart';

final FileClient fileClient = FileClient(Dio());

@RestApi()
abstract class FileClient {
  factory FileClient(Dio dio, {String baseUrl}) = _FileClient;

  @PUT("{presignedUrl}")
  @Headers({"content-type": "application/octet-stream"})
  Future<void> upload({
    @Path() required String presignedUrl,
    @Body() required Uint8List file,
  });
}
