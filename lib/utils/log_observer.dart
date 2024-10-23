import 'package:dears/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogObserver extends ProviderObserver {
  const LogObserver();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger.d("$provider added with $value");
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.e("$provider failed", error: error, stackTrace: stackTrace);
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d("$provider updated from $previousValue to $newValue");
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    logger.d("$provider disposed");
  }
}
