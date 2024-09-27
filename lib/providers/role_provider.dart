import 'package:dears/models/member_role.dart';
import 'package:dears/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_provider.g.dart';

const String _key = "role";

@riverpod
class Role extends _$Role {
  @override
  Future<MemberRole> build() async {
    final prefs = ref.watch(prefsProvider);
    final value = await prefs.getString(_key);
    return _fromString(value);
  }

  Future<void> fix(MemberRole value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = ref.read(prefsProvider);
      await prefs.setString(_key, _toString(value));
      return value;
    });
  }

  Future<bool> get isFixed {
    final prefs = ref.read(prefsProvider);
    return prefs.containsKey(_key);
  }
}

const String _customer = "CUSTOMER";
const String _weddingPlanner = "WEDDING_PLANNER";

MemberRole _fromString(String? value) {
  return switch (value) {
    _customer => MemberRole.customer,
    _weddingPlanner => MemberRole.weddingPlanner,
    _ => MemberRole.defaultValue,
  };
}

String _toString(MemberRole role) {
  return switch (role) {
    MemberRole.customer => _customer,
    MemberRole.weddingPlanner => _weddingPlanner,
  };
}
