import 'dart:convert';

import 'package:dears/models/member_create_body.dart';
import 'package:dears/models/member_role.dart';
import 'package:dears/models/user.dart';
import 'package:dears/providers/access_token_provider.dart';
import 'package:dears/providers/auth_client_provider.dart';
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
    state = await AsyncValue.guard(() async {
      final data = await future;
      final user = User(role: data.role.toggled);
      return _saveEncoded(user);
    });
  }

  Future<void> signUp() async {
    state = await AsyncValue.guard(() async {
      final data = await future;

      final authClient = await ref.read(authClientProvider.future);

      final member = await authClient.createMember(
        data: MemberCreateBody(role: data.role),
      );

      await ref.read(accessTokenProvider.notifier).setValue(member.uuid);

      final user = data.copyWith(uuid: member.uuid);
      return _saveEncoded(user);
    });
  }
  // TODO: need to fix this
  Future<void> signUpWithRole(MemberRole role) async {
    state = await AsyncValue.guard(() async {
      final authClient = await ref.read(authClientProvider.future);
      final member = await authClient.createMember(
        data: MemberCreateBody(role: role),
      );
      await ref.read(accessTokenProvider.notifier).setValue(member.uuid);
      final user = User(role: role, uuid: member.uuid);
      return _saveEncoded(user);
    });
  }
  
  Future<void> logout() async {
    state = await AsyncValue.guard(() async {
      final data = await future;
      final user = data.copyWith(uuid: null);
      await ref.read(accessTokenProvider.notifier).clear();
      return _saveEncoded(user);
    });
  }
}
