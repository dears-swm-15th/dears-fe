import 'package:dears/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_role_fixed_provider.g.dart';

const String _key = "is_role_fixed";

@riverpod
class IsRoleFixed extends _$IsRoleFixed {
  @override
  Future<bool> build() async {
    final prefs = ref.watch(prefsProvider);
    final value = await prefs.getBool(_key);
    return value ?? false;
  }

  Future<void> fix() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.read(prefsProvider);
      await prefs.setBool(_key, true);
      return true;
    });
  }
}
