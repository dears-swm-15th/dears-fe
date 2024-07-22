import 'package:dears/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PersonalListTile extends HookWidget {
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Widget? leading;
  final double titleSpacing;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  const PersonalListTile({
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.leading,
    this.titleSpacing = 12,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final tapped = useState(false);

    final leading = this.leading;

    Widget? trailing = this.trailing;
    if (trailing != null) {
      trailing = IconTheme(
        data: const IconThemeData(size: 18),
        child: trailing,
      );
    }

    Widget title = DefaultTextStyle(
      style: const TextStyle(
        color: gray800,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      child: this.title,
    );

    final subtitle = this.subtitle;
    if (subtitle != null) {
      title = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          DefaultTextStyle(
            style: const TextStyle(
              color: gray600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            child: subtitle,
          ),
        ],
      );
    }

    final child = Container(
      padding: padding,
      color: !tapped.value
          ? null
          : CupertinoColors.systemGrey4.resolveFrom(context),
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            SizedBox(width: titleSpacing),
          ],
          title,
          if (trailing != null) ...[
            const Spacer(),
            trailing,
          ],
        ],
      ),
    );

    final onTap = this.onTap;
    if (onTap == null) {
      return child;
    }

    return GestureDetector(
      onTapDown: (details) => tapped.value = true,
      onTapCancel: () => tapped.value = false,
      onTap: () {
        onTap();
        tapped.value = false;
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
