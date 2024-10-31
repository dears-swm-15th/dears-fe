import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/portfolio_create_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioCreateServiceFieldList extends ConsumerStatefulWidget {
  const PortfolioCreateServiceFieldList({super.key});

  @override
  ConsumerState<PortfolioCreateServiceFieldList> createState() =>
      _PortfolioCreateServiceFieldListState();
}

class _PortfolioCreateServiceFieldListState
    extends ConsumerState<PortfolioCreateServiceFieldList> {
  final keys = [UniqueKey()];

  void addService() {
    keys.add(UniqueKey());
    ref.read(portfolioCreateFormProvider.notifier).addService();
  }

  void removeServiceAt(int index) {
    keys.removeAt(index);
    ref.read(portfolioCreateFormProvider.notifier).removeServiceAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final length = ref.watch(
      portfolioCreateFormProvider.select((value) => value.services.length),
    );

    return Column(
      children: [
        for (int i = 0; i < length; i++) ...[
          PortfolioCreateTextField(
            key: keys[i],
            hintText: "서비스를 입력해주세요",
            suffixIcon: length == 1
                ? null
                : IconButton(
                    onPressed: () => removeServiceAt(i),
                    icon: const Icon(Icons.remove),
                  ),
            onChanged: (value) => ref
                .read(portfolioCreateFormProvider.notifier)
                .setServiceAt(i, value),
          ),
          const SizedBox(height: 8),
        ],
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => addService(),
          icon: const Icon(Icons.add_circle, size: 32, color: blue50),
        ),
        const Text("추가", style: captionLarge),
      ],
    );
  }
}
