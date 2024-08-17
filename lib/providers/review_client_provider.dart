import 'package:dears/clients/review_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_client_provider.g.dart';

@riverpod
ReviewClient reviewClient(ReviewClientRef ref) {
  final dio = ref.watch(apiDioProvider);
  return ReviewClient(dio);
}
