import 'package:dears/providers/uuid_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_signed_in_provider.g.dart';

@riverpod
Raw<Future<bool>> isSignedIn(Ref ref) {
  return ref.watch(
    uuidProvider.selectAsync((data) => data != null),
  );
}
