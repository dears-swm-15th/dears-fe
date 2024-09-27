import 'package:dears/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerPage extends ConsumerWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planner Page"),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(authStateProvider.notifier).signOut();
          },
          child: const Text("Sign Out"),
        ),
      ),
    );
  }
}
