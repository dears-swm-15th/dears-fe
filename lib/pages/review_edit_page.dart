import 'package:dears/providers/portfolio_provider.dart';
import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/review_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _imageHeight = 54;

class ReviewEditPage extends ConsumerWidget {
  final int portfolioId;

  const ReviewEditPage({
    super.key,
    required this.portfolioId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(portfolioProvider(portfolioId));

    final tile = portfolio.maybeWhen(
      data: (data) {
        return Row(
          children: [
            CdnImage(
              data.profileImageUrl,
              width: _imageHeight,
              height: _imageHeight,
              borderRadius: BorderRadius.circular(4),
              fallback: const Icon(DearsIcons.person, size: 32),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.name} 웨딩플래너",
                  style: titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  data.organization,
                  style: bodySmall.copyWith(color: gray600),
                ),
              ],
            ),
          ],
        );
      },
      orElse: () => const SizedBox(height: _imageHeight),
    );

    final enabled = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.enabled),
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("웨딩플래너 평가 작성"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: tile,
          ),
          const SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ReviewInput(portfolioId),
          ),
          const SizedBox(height: 30),
          const Divider(thickness: 4, color: blue50),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: blue50,
            child: Column(
              children: [
                const SizedBox(height: 46),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: enabled
                      ? () async {
                          await ref
                              .read(reviewFormProvider(portfolioId).notifier)
                              .submit(portfolioId);

                          if (!context.mounted) return;
                          context.pop();
                        }
                      : null,
                  child: const Text("리뷰 작성하기"),
                ),
                SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
