import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/portfolio_create_profile_image_picker.dart';
import 'package:dears/widgets/portfolio_create_text_field.dart';
import 'package:dears/widgets/portfolio_image_picker.dart';
import 'package:dears/widgets/portfolio_info_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioCreatePage extends ConsumerWidget {
  const PortfolioCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(
      portfolioCreateFormProvider.select((value) => value.enabled),
    );

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: const Text("포트폴리오 작성"),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).signOut();
            },
            icon: const Icon(DearsIcons.close),
          ),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: gray600),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue500),
            ),
          ),
        ),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const Divider(color: gray100),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: PortfolioCreateProfileImagePicker(),
                  ),
                  SizedBox(height: 30),
                  Text("대표이미지", style: titleSmall),
                  SizedBox(height: 8),
                  PortfolioImagePicker(),
                ],
              ),
            ),
            const Divider(color: gray100, thickness: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: PortfolioInfoForm(),
            ),
            const Divider(color: gray100, thickness: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("상세 설명 작성", style: titleLarge),
                  const SizedBox(height: 12),
                  PortfolioCreateTextField(
                    hintText: "자세한 설명을 작성해주세요",
                    maxLines: null,
                    minLines: 10,
                    onChanged: (value) => ref
                        .read(portfolioCreateFormProvider.notifier)
                        .setContent(value),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: enabled
                          ? () async {
                              await ref
                                  .read(portfolioCreateFormProvider.notifier)
                                  .submit();

                              if (!context.mounted) return;
                              context.go("/planner");
                            }
                          : null,
                      child: const Text("저장"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
