import 'package:dears/providers/register_portfolio_form_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

const int _imageLimit = 10;

class PortfolioImagePicker extends ConsumerWidget {
  const PortfolioImagePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(
      registerPortfolioFormProvider.select((value) => value.portfolioImages),
    );
    final imageCount = images.length;

    final picker = GestureDetector(
      onTap: () async {
        final count = _imageLimit - imageCount;
        if (count <= 0) {
          // TODO: give user feedback
          return;
        }

        final picker = ImagePicker();
        final files = await picker.pickMultiImage();

        // TODO: give user feedback when selected images exceed the limit

        final images = await Future.wait(
          files.take(count).map((e) async {
            final bytes = await e.readAsBytes();
            return (e.name, bytes);
          }),
        );
        ref.read(registerPortfolioFormProvider.notifier).addPortfolioImages(images);
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
              "$imageCount/$_imageLimit",
              style: captionSmall.copyWith(color: gray600),
            ),
          ],
        ),
      ),
    );

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        picker,
        ...List.generate(images.length, (index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
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
              ),
              Positioned(
                top: -6,
                right: -6,
                child: GestureDetector(
                  onTap: () => ref
                      .read(registerPortfolioFormProvider.notifier)
                      .removePortfolioImageAt(index),
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(DearsIcons.cancel, size: 20),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
