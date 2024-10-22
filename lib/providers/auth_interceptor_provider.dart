import 'package:dears/providers/access_token_provider.dart';
import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptor_provider.g.dart';

@riverpod
Interceptor authInterceptor(AuthInterceptorRef ref, Dio dio) {
  bool isRefreshing = false;
  final retryQueue = <(RequestOptions, ErrorInterceptorHandler)>[];

  Future<void> handleUnauthorized(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) async {
    retryQueue.add((options, handler));
    if (isRefreshing) {
      return;
    }

    try {
      isRefreshing = true;

      logger.t("token refreshing");
      await ref.read(authStateProvider.notifier).refresh();

      for (final (options, handler) in retryQueue) {
        dio.fetch(options).then(handler.resolve).catchError((e) {
          if (e is DioException) {
            handler.next(e);
          }
          // ignore other errors
        });
      }
    } on TokenRefreshException catch (_) {
      logger.i("sign out due to refresh token failure");
      await ref.read(authStateProvider.notifier).signOut();
    } finally {
      retryQueue.clear();
      isRefreshing = false;
    }
  }

  return InterceptorsWrapper(
    onRequest: (options, handler) async {
      final accessToken = await ref.read(accessTokenProvider.future);
      return handler.next(options..accessToken = accessToken);
    },
    onError: (error, handler) async {
      final statusCode = error.response?.statusCode;
      if (statusCode == 401) {
        final options = error.requestOptions;

        if (options.isTokenRefresh) {
          logger.e("failed to refresh tokens, i.e. refresh token is expired");
          return handler.next(error);
        }

        return await handleUnauthorized(options, handler);
      }

      return handler.next(error);
    },
  );
}

extension on RequestOptions {
  set accessToken(String? value) {
    if (value != null) {
      headers["Authorization"] = "Bearer $value";
    } else {
      headers.remove("Authorization");
    }
  }

  bool get isTokenRefresh => extra["type"] == "token_refresh";
}
