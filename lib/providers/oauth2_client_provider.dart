import 'package:dears/clients/oauth2_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'oauth2_client_provider.g.dart';

@riverpod
Future<OAuth2Client> oauth2Client(Ref ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return OAuth2Client(dio);
}
