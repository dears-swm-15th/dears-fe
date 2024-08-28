import 'package:dears/providers/stomp_provider.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatTextField extends HookConsumerWidget {
  final int chatroomId;

  const ChatTextField({
    super.key,
    required this.chatroomId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isEmpty = useState(true);

    useEffect(
      () {
        void listener() {
          // If all the characters are whitespaces, it is considered empty.
          isEmpty.value = RegExp(r'^\s*$').hasMatch(controller.text);
        }

        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      const [],
    );

    final focusNode = useFocusNode();
    final isFocused = useState(false);

    useEffect(
      () {
        void listener() {
          isFocused.value = focusNode.hasFocus;
        }

        focusNode.addListener(listener);
        return () => focusNode.removeListener(listener);
      },
      const [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isFocused.value ? DearsIcons.add : DearsIcons.link,
              color: gray600,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                style: bodySmall,
                decoration: const InputDecoration(
                  hintText: "메시지를 입력해주세요",
                  hintStyle: TextStyle(color: gray600),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: gray100,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 4,
                minLines: 1,
                scrollPhysics: const ClampingScrollPhysics(),
              ),
            ),
          ),
          IconButton(
            color: blue500,
            disabledColor: black,
            onPressed: isEmpty.value
                ? null
                : () {
                    ref
                        .read(stompProvider.notifier)
                        .send(chatroomId, controller.text);
                    controller.clear();
                  },
            icon: const Icon(DearsIcons.paper_plane_right),
          ),
        ],
      ),
    );
  }
}
