import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/widgets.dart';

class PersonalListTile extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;

  const PersonalListTile({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: bodyLarge),
            const Icon(DearsIcons.caret_right, size: 18),
          ],
        ),
      ),
    );
  }
}
