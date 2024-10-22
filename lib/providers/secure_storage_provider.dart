import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

@riverpod
FlutterSecureStorage storage(StorageRef ref) {
  return const FlutterSecureStorage();
}

mixin SecureStorageProviderMixin on AsyncNotifier<String?> {
  String get key;

  @override
  Future<String?> build() async {
    final storage = ref.read(storageProvider);
    return storage.read(key: key);
  }

  Future<String?> _save(String? value) async {
    final storage = ref.read(storageProvider);
    await storage.write(key: key, value: value);
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
