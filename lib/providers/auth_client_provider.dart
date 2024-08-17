import 'package:dears/clients/auth_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_client_provider.g.dart';

@riverpod
Future<AuthClient> authClient(AuthClientRef ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return AuthClient(dio);
}
