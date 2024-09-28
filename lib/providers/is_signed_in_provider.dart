import 'package:dears/providers/uuid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_signed_in_provider.g.dart';

@riverpod
Raw<Future<bool>> isSignedIn(IsSignedInRef ref) {
  return ref.watch(
    uuidProvider.selectAsync((data) => data != null),
  );
}
