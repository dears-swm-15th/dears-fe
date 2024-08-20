import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewImagePicker extends HookWidget {
  const ReviewImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final images = useState(<int>{});

    final picker = GestureDetector(
      onTap: () {
        final list = images.value..add(images.value.length);
        images.value = {...list};
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
        ...List.generate(images.value.length, (index) {
          final seed = index + 1;

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
                child: Image.network(
                  "https://picsum.photos/seed/$seed/200/300",
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
