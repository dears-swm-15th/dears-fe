import 'package:dears/providers/access_token_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor_provider.g.dart';

@riverpod
Future<Interceptor> authInterceptor(AuthInterceptorRef ref) async {
  final accessToken = await ref.watch(accessTokenProvider.future);

  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }

      return handler.next(options);
    },
  );
}
