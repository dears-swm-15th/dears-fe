import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(toolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: AppBarTheme.of(context).backgroundColor,
      child: AppBar(
        leading: leading,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
        leadingWidth: toolbarHeight,
      ),
    );
  }
}
