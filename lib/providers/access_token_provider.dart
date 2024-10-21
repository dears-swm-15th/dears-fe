import 'package:dears/providers/secure_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'access_token_provider.g.dart';

@Riverpod(keepAlive: true)
class AccessToken extends _$AccessToken with SecureStorageProviderMixin {
  @protected
  @override
  final key = "access_token";

  @override
  Future<String?> build();
}
