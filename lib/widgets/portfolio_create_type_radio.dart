import 'package:dears/models/accompany_type.dart';
import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioCreateTypeRadio extends ConsumerWidget {
  const PortfolioCreateTypeRadio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      portfolioCreateFormProvider.select((value) => value.type),
    );

    return Row(
      children: <Widget>[
        for (final type in AccompanyType.values)
          Expanded(
            child: OutlinedButton(
              onPressed: () => ref
                  .read(portfolioCreateFormProvider.notifier)
                  .setAccompanyType(type),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: type == selected ? blue500 : gray100,
                ),
                textStyle: bodyLarge,
              ),
              child: Text(
                type.label,
                style: TextStyle(
                  color: type == selected ? blue500 : gray600,
                ),
              ),
            ),
          ),
      ].separated(const SizedBox(width: 8)).toList(),
    );
  }
}
