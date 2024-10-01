import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/providers/register_portfolio_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/portfolio_image_picker.dart';
import 'package:dears/widgets/portfolio_info_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class RegisterPortfolioPage extends ConsumerWidget {
  const RegisterPortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioFormProvider = ref.watch(registerPortfolioFormProvider);
    final contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(height: 1, color: gray100),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: (portfolioFormProvider.profileImage.$1.isEmpty)
                        ? CdnImage.circle(
                      "",
                      dimension: 100,
                      fallback: const Icon(DearsIcons.person, size: 36),
                    )
                        : ClipOval(
                      child: Image.memory(
                        portfolioFormProvider.profileImage.$2,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final file =
                        await picker.pickImage(source: ImageSource.gallery);

                        if (file != null) {
                          final bytes = await file.readAsBytes();
                          final image = (file.name, bytes);

                          ref
                              .read(registerPortfolioFormProvider.notifier)
                              .setProfileImages(image);
                        } else {
                          // TODO: give user feedback that no image was selected
                        }
                      },
                      child: const Text(
                        "프로필 이미지 선택",
                        style: TextStyle(color: blue500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "대표이미지",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const PortfolioImagePicker(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Divider outside the padding
            const Divider(color: gray100, thickness: 4),
            const SizedBox(height: 20),
            const PortfolioInfoForm(),
            const SizedBox(height: 20),
            const Divider(color: gray100, thickness: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "상세 설명 작성",
                    style: titleLarge,
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: contentController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: "자세한 설명을 작성해주세요",
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        ref
                            .read(registerPortfolioFormProvider.notifier)
                            .setContent(contentController.text);
                        ref
                            .read(registerPortfolioFormProvider.notifier)
                            .submit();

                        //TODO: routing
                        context.go("/planner");
                      },
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
