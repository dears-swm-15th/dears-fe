import 'package:dears/providers/auth_interceptor_provider.dart';
import 'package:dears/providers/role_interceptor_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:dears/utils/log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_dio_provider.g.dart';

@riverpod
Future<Dio> apiDio(Ref ref) async {
  final dio = Dio()
    // `retrofit` combines `Dio.options.baseUrl` and `RestApi.baseUrl`
    // using `Uri.resolveUri` method. To merge the two URLs correctly,
    // `Dio.options.baseUrl` should end with a trailing slash
    // and `RestApi.baseUrl` should not start with a leading slash.
    ..options.baseUrl = "$baseUrl/api/";

  final roleInterceptor = await ref.watch(roleInterceptorProvider.future);
  dio.interceptors.add(roleInterceptor);

  final authInterceptor = ref.watch(authInterceptorProvider(dio));
  dio.interceptors.add(authInterceptor);

  dio.interceptors.add(const CustomLogInterceptor());

  return dio;
}
