import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/portfolio_create_cost_field.dart';
import 'package:dears/widgets/portfolio_create_region_radio.dart';
import 'package:dears/widgets/portfolio_create_service_field_list.dart';
import 'package:dears/widgets/portfolio_create_text_field.dart';
import 'package:dears/widgets/portfolio_create_type_radio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioInfoForm extends ConsumerWidget {
  const PortfolioInfoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("웨딩플래너 기본정보 작성", style: titleLarge),
        const SizedBox(height: 20),
        const Text("이름", style: bodyLarge),
        const SizedBox(height: 8),
        PortfolioCreateTextField(
          hintText: "이름을 입력해주세요",
          onChanged: (value) => ref
              .read(portfolioCreateFormProvider.notifier)
              .setPlannerName(value),
        ),
        const SizedBox(height: 20),
        const Text("회사명", style: bodyLarge),
        const SizedBox(height: 8),
        PortfolioCreateTextField(
          hintText: "회사명을 입력해주세요",
          onChanged: (value) => ref
              .read(portfolioCreateFormProvider.notifier)
              .setCompanyName(value),
        ),
        const SizedBox(height: 20),
        const Text("자기소개", style: bodyLarge),
        const SizedBox(height: 8),
        PortfolioCreateTextField(
          hintText: "소개하는 글을 입력해주세요",
          maxLines: 3,
          onChanged: (value) => ref
              .read(portfolioCreateFormProvider.notifier)
              .setIntroduce(value),
        ),
        const SizedBox(height: 20),
        const Text("활동지역", style: bodyLarge),
        const SizedBox(height: 8),
        const PortfolioCreateRegionRadio(),
        const SizedBox(height: 20),
        const Text("유형", style: bodyLarge),
        const SizedBox(height: 8),
        const PortfolioCreateTypeRadio(),
        const SizedBox(height: 20),
        const Text("제공 서비스", style: bodyLarge),
        const SizedBox(height: 8),
        const PortfolioCreateServiceFieldList(),
        const SizedBox(height: 20),
        const Text("상담비용", style: bodyLarge),
        const SizedBox(height: 8),
        PortfolioCreateCostField(
          onChanged: (value) =>
              ref.read(portfolioCreateFormProvider.notifier).setCost(value),
        ),
      ],
    );
  }
}
