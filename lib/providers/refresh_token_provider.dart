import 'package:dears/providers/secure_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_token_provider.g.dart';

@Riverpod(keepAlive: true)
class RefreshToken extends _$RefreshToken with SecureStorageProviderMixin {
  @protected
  @override
  final key = "refresh_token";

  @override
  Future<String?> build();
}
