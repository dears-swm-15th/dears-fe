import 'package:dears/utils/env.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor_provider.g.dart';

@riverpod
Interceptor authInterceptor(AuthInterceptorRef ref) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers["Authorization"] = "Bearer $uuid";
      return handler.next(options);
    },
  );
}
