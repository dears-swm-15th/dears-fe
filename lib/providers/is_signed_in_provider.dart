import 'package:dears/providers/access_token_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_signed_in_provider.g.dart';

@Riverpod(keepAlive: true)
Future<bool> isSignedIn(IsSignedInRef ref) async {
  final token = await ref.watch(accessTokenProvider.future);
  return token != null;
}
