import 'package:dears/providers/stomp_provider.dart';
import 'package:dears/utils/provider_observer.dart';
import 'package:dears/utils/router.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      observers: [MainObserver()],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stompProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: theme,
    );
  }
}
