import 'package:dears/providers/inquiry_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InquiryTextField extends HookConsumerWidget {
  const InquiryTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    useEffect(
      () {
        void listener() {
          ref.read(inquiryFormProvider.notifier).setContent(controller.text);
        }

        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      const [],
    );

    ref.listen(
      inquiryFormProvider.select((value) => value.content),
      (previous, next) {
        if (controller.text != next) {
          print("controller.text: ${controller.text}");
          controller.text = next;
        }
      },
    );

    return TextField(
      controller: controller,
      style: bodySmallLong,
      decoration: const InputDecoration(
        hintText: "내용을 작성해주세요",
        hintStyle: TextStyle(color: gray600),
        hintMaxLines: 3,
        contentPadding: EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: gray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blue500),
        ),
      ),
      maxLines: null,
      minLines: 3,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }
}
