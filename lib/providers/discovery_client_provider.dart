import 'package:dears/clients/discovery_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discovery_client_provider.g.dart';

@riverpod
Future<DiscoveryClient> discoveryClient(DiscoveryClientRef ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return DiscoveryClient(dio);
}
