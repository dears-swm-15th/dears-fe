import 'package:dears/providers/my_portfolio_provider.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showPortfolioDeleteDialog(
  BuildContext context,
  WidgetRef ref, {
  required int portfolioId,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(DearsIcons.info, size: 50, color: blue100),
              const SizedBox(height: 8),
              const Text("정말 삭제하시겠습니까?", style: titleLarge),
              const SizedBox(height: 8),
              const Text(
                "삭제하시면 복구할 수 없습니다.",
                style: TextStyle(color: gray600),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: gray100,
                        foregroundColor: gray800,
                      ),
                      child: const Text("취소"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        final portfolioClient =
                            await ref.read(portfolioClientProvider.future);
                        await portfolioClient.delete(portfolioId);

                        ref.invalidate(myPortfolioProvider);

                        if (!context.mounted) return;
                        context.go("/");
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: red,
                      ),
                      child: const Text("삭제"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
