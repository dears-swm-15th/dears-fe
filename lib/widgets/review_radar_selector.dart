import 'package:dears/models/radar_key.dart';
import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewRadarSelector extends HookConsumerWidget {
  final int portfolioId;
  final RadarKey radarKey;
  final String title;
  final String subtitle;
  final String lowLabel;
  final String middleLabel;
  final String highLabel;

  const ReviewRadarSelector({
    super.key,
    required this.portfolioId,
    required this.radarKey,
    required this.title,
    required this.subtitle,
    required this.lowLabel,
    required this.middleLabel,
    required this.highLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labels = [lowLabel, middleLabel, highLabel];

    final selected = ref.watch(
      reviewFormProvider(portfolioId)
          .select((value) => value.radarIndexes[radarKey]),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleSmall.copyWith(color: blue500),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: bodyLarge),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ...List<Widget>.generate(3, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final value = selected != index ? index : null;
                      ref
                          .read(reviewFormProvider(portfolioId).notifier)
                          .setRadarIndex(radarKey, value);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Icon(
                          // TODO: replace with custom icon
                          Icons.face,
                          size: 32,
                          color: selected == index ? blue500 : null,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: captionLarge.copyWith(
                            color: selected == index ? blue500 : gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).separated(const SizedBox(width: 4)),
            ],
          ),
        ),
      ],
    );
  }
}
