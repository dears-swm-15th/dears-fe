import 'package:dears/clients/mypage_client.dart';
import 'package:dears/models/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
Future<Profile> profile(ProfileRef ref) {
  return mypageClient.getProfile();
}
