import 'package:dears/providers/auth_interceptor_provider.dart';
import 'package:dears/utils/dio.dart';
import 'package:dears/utils/env.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_dio_provider.g.dart';

@riverpod
Future<Dio> apiDio(ApiDioRef ref) async {
  final dio = Dio()
    // `retrofit` combines `Dio.options.baseUrl` and `RestApi.baseUrl`
    // using `Uri.resolveUri` method. To merge the two URLs correctly,
    // `Dio.options.baseUrl` should end with a trailing slash
    // and `RestApi.baseUrl` should not start with a leading slash.
    ..options.baseUrl = "$baseUrl/api/";

  final authInterceptor = await ref.watch(authInterceptorProvider.future);
  dio.interceptors.add(authInterceptor);

  dio.interceptors.add(logInterceptor);

  return dio;
}