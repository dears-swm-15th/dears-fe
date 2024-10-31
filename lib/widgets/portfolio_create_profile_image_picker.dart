import 'package:dears/models/image_data.dart';
import 'package:dears/providers/portfolio_create_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PortfolioCreateProfileImagePicker extends ConsumerWidget {
  const PortfolioCreateProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(
      portfolioCreateFormProvider.select((value) => value.profileImage),
    );

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const ShapeDecoration(
            color: gray100,
            shape: CircleBorder(),
          ),
          child: profileImage != null
              ? ClipOval(
                  child: Image.memory(
                    profileImage.data,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(DearsIcons.person, size: 36),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () async {
            final picker = ImagePicker();
            final file = await picker.pickImage(source: ImageSource.gallery);
            if (file == null) {
              return;
            }

            final bytes = await file.readAsBytes();
            ref
                .read(portfolioCreateFormProvider.notifier)
                .setProfileImages(ImageData(file.name, bytes));
          },
          child: const Text(
            "프로필 이미지 선택",
            style: TextStyle(color: blue500),
          ),
        ),
      ],
    );
  }
}
