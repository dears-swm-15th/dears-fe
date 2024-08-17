import 'package:dears/models/member_create_body.dart';
import 'package:dears/models/member_role.dart';
import 'package:dears/providers/auth_client_provider.dart';
import 'package:dears/providers/secure_storage_provider.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'access_token_provider.g.dart';

const String _key = "access_token";

@Riverpod(keepAlive: true)
class AccessToken extends _$AccessToken {
  @override
  Future<String?> build() async {
    final storage = ref.read(storageProvider);

    final value = await storage.read(key: _key);
    if (value == null) {
      final authClient = ref.read(authClientProvider);
      final member = await authClient.createMember(
        data: const MemberCreateBody(
          role: MemberRole.defaultValue,
        ),
      );
      await ref.read(userInfoProvider.notifier).setUserId(member.uuid);
      return _save(member.uuid);
    }

    return value;
  }

  Future<String> _save(String value) async {
    final storage = ref.read(storageProvider);
    await storage.write(key: _key, value: value);
    return value;
  }
}
