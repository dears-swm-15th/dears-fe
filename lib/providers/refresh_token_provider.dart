import 'package:dears/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_token_provider.g.dart';

const String _key = "refresh_token";

@riverpod
class RefreshToken extends _$RefreshToken {
  @override
  Future<String?> build() async {
    final storage = ref.watch(storageProvider);
    return storage.read(key: _key);
  }

  Future<String?> _save(String? value) async {
    final storage = ref.read(storageProvider);
    await storage.write(key: _key, value: value);
    return value;
  }

  Future<void> setValue(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _save(value));
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _save(null));
  }
}
