import 'package:dears/providers/secure_storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'uuid_provider.g.dart';

@Riverpod(keepAlive: true)
class Uuid extends _$Uuid with SecureStorageProviderMixin {
  @protected
  @override
  final key = "uuid";

  @override
  Future<String?> build();
}
