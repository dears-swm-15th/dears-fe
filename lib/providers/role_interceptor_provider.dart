import 'package:dears/providers/user_info_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_interceptor_provider.g.dart';

@riverpod
Future<Interceptor> roleInterceptor(RoleInterceptorRef ref) async {
  final role = await ref.watch(
    userInfoProvider.selectAsync((data) => data.role),
  );

  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (options.path.startsWith("/{role}")) {
        options.path = options.path.replaceFirst("{role}", role.apiPrefix);
      }

      return handler.next(options);
    },
  );
}
