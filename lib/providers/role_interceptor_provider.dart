import 'package:dears/providers/role_provider.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_interceptor_provider.g.dart';

/// A provider that returns an interceptor that replaces the path with the role.
/// It gets the role from the [roleProvider] and prepends the role to the path
/// if the path starts with `/{role}`.
@riverpod
Future<Interceptor> roleInterceptor(Ref ref) async {
  final role = await ref.watch(roleProvider.future);

  return InterceptorsWrapper(
    onRequest: (options, handler) {
      if (options.path.startsWith("/{role}")) {
        options.path = options.path.replaceFirst("{role}", role.apiPrefix);
      }

      return handler.next(options);
    },
  );
}
