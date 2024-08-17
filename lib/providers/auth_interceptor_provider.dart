import 'package:dears/providers/access_token_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor_provider.g.dart';

@riverpod
Interceptor authInterceptor(AuthInterceptorRef ref) {
  // TODO: refactor to wait future
  final accessToken =
      ref.watch(accessTokenProvider).unwrapPrevious().valueOrNull;

  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }

      return handler.next(options);
    },
  );
}
