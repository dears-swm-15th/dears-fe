import 'package:dears/clients/review_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_client_provider.g.dart';

@riverpod
Future<ReviewClient> reviewClient(Ref ref) async {
  final dio = await ref.watch(apiDioProvider.future);
  return ReviewClient(dio);
}
