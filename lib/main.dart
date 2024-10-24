import 'package:dears/firebase_options.dart';
import 'package:dears/providers/router_provider.dart';
import 'package:dears/providers/stomp_provider.dart';
import 'package:dears/utils/env.dart';
import 'package:dears/utils/log_observer.dart';
import 'package:dears/utils/theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  runApp(
    const ProviderScope(
      observers: [LogObserver()],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stompProvider);

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: theme,
    );
  }
}
