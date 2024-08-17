import 'package:dears/models/profile.dart';
import 'package:dears/providers/mypage_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
Future<Profile> profile(ProfileRef ref) {
  final mypageClient = ref.watch(mypageClientProvider);
  return mypageClient.getProfile();
}
