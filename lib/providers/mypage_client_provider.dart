import 'package:dears/clients/mypage_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mypage_client_provider.g.dart';

@riverpod
MypageClient mypageClient(MypageClientRef ref) {
  final dio = ref.watch(apiDioProvider);
  return MypageClient(dio);
}
