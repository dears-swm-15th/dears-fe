import 'package:dears/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainObserver extends ProviderObserver {
  const MainObserver();

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.d(provider, error: error, stackTrace: stackTrace);
  }
}
