import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchTextField extends HookWidget {
  final String? text;
  final ValueChanged<String>? onSubmitted;
  final TapRegionCallback? onTapOutside;

  const SearchTextField({
    super.key,
    this.text,
    this.onSubmitted,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: text);
    final isEmpty = useState(controller.text.isEmpty);

    useEffect(
      () {
        void listener() {
          isEmpty.value = controller.text.isEmpty;
        }

        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      const [],
    );

    final suffixIcon = isEmpty.value
        ? const SizedBox.square(dimension: 16)
        : IconButton(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            padding: EdgeInsets.zero,
            onPressed: controller.clear,
            icon: const Icon(DearsIcons.cancel, size: 16, color: gray600),
          );

    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        style: bodySmall,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: "검색어를 입력하세요",
          hintStyle: const TextStyle(color: gray600),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8, right: 4),
            child: Icon(DearsIcons.search, color: gray600),
          ),
          prefixIconConstraints: const BoxConstraints(),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: suffixIcon,
          ),
          suffixIconConstraints: const BoxConstraints(),
          filled: true,
          fillColor: blue50,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          onSubmitted?.call(search.format(value));
          controller.clear();
        },
        onTapOutside: onTapOutside,
      ),
    );
  }
}
