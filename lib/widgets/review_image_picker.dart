import 'package:dears/providers/review_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ReviewImagePicker extends ConsumerWidget {
  final int portfolioId;

  const ReviewImagePicker(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(
      reviewFormProvider(portfolioId).select((value) => value.images),
    );

    final picker = GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final files = await picker.pickMultiImage();

        final images = await Future.wait(
          files.map((e) async {
            final bytes = await e.readAsBytes();
            return (e.name, bytes);
          }),
        );
        ref.read(reviewFormProvider(portfolioId).notifier).addImages(images);
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: gray100),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(DearsIcons.camera, color: gray600),
            Text(
              "선택",
              style: captionSmall.copyWith(color: gray600),
            ),
          ],
        ),
      ),
    );

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        picker,
        ...List.generate(images.length, (index) {
          return SizedBox(
            width: 60,
            height: 60,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: gray100,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.memory(
                  images[index].$2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
