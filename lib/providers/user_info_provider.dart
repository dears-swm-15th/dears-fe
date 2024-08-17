import 'dart:convert';

import 'package:dears/models/user.dart';
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

  Future<void> toggle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final data = await future;
      final user = User(role: data.role.toggled);
      return _saveEncoded(user);
    });
  }

  Future<void> setUserId(String uuid) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final data = await future;
      final user = data.copyWith(uuid: uuid);
      return _saveEncoded(user);
    });
  }
}
