import 'package:dears/providers/user_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_signed_in_provider.g.dart';

@riverpod
Future<bool> isSignedIn(IsSignedInRef ref) {
  return ref.watch(
    userInfoProvider.selectAsync((data) => data.uuid != null),
  );
}
