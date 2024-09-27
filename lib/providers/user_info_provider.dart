import 'dart:convert';

import 'package:dears/models/member_role.dart';
import 'package:dears/models/user.dart';
import 'package:dears/providers/is_role_fixed_provider.dart';
import 'package:dears/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_provider.g.dart';

const String _key = "user_info";

@riverpod
class UserInfo extends _$UserInfo {
  @override
  Future<User> build() async {
    final prefs = ref.watch(prefsProvider);

    final value = await prefs.getString(_key);
    if (value == null) {
      return _saveEncoded(User.defaultValue);
    }

    final json = jsonDecode(value) as Map<String, dynamic>;
    return User.fromJson(json);
  }

  Future<User> _saveEncoded(User user) async {
    final prefs = ref.read(prefsProvider);
    await prefs.setString(_key, jsonEncode(user));
    return user;
  }

  // TODO: validate that role is unfixed
  Future<void> setRole(MemberRole role) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = User(role: role);

      await _saveEncoded(user);
      await ref.read(isRoleFixedProvider.notifier).fix();
      return user;
    });
  }
}
