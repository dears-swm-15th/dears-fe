import 'package:dears/utils/env.dart';
import 'package:dio/dio.dart';

final dio = Dio()
  // `retrofit` combines `Dio.options.baseUrl` and `RestApi.baseUrl`
  // using `Uri.resolveUri` method. To merge the two URLs correctly,
  // `Dio.options.baseUrl` should end with a trailing slash
  // and `RestApi.baseUrl` should not start with a leading slash.
  ..options.baseUrl = "$baseUrl/api/";
