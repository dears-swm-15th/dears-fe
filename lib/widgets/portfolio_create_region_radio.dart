import 'package:dears/models/region.dart';
import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioCreateRegionRadio extends ConsumerWidget {
  const PortfolioCreateRegionRadio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      portfolioCreateFormProvider.select((value) => value.region),
    );

    return Row(
      children: <Widget>[
        for (final region in Region.values)
          Expanded(
            child: OutlinedButton(
              onPressed: () => ref
                  .read(portfolioCreateFormProvider.notifier)
                  .setRegion(region),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: region == selected ? blue500 : gray100,
                ),
                textStyle: bodyLarge,
              ),
              child: Text(
                region.name,
                style: TextStyle(
                  color: region == selected ? blue500 : gray600,
                ),
              ),
            ),
          ),
      ].separated(const SizedBox(width: 8)).toList(),
    );
  }
}
