import 'package:flutter/material.dart';

class DetailsSliverAppBar extends StatefulWidget {
  final bool pinned;
  final bool? centerTitle;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? background;

  const DetailsSliverAppBar({
    super.key,
    this.pinned = false,
    this.centerTitle,
    this.title,
    this.actions,
    this.background,
  });

  @override
  State<DetailsSliverAppBar> createState() => _DetailsSliverAppBarState();
}

class _DetailsSliverAppBarState extends State<DetailsSliverAppBar> {
  final key = GlobalKey();
  double? height;

  @override
  void initState() {
    super.initState();
    updateHeight();
  }

  @override
  void didUpdateWidget(covariant DetailsSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateHeight();
  }

  void updateHeight() {
    // Gets the new height and updates the sliver app bar.
    // Needs to be called after the last frame has been rebuild,
    // otherwise this will throw an error.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentContext = key.currentContext;
      if (currentContext == null) {
        return;
      }

      final renderObject = currentContext.findRenderObject();
      if (renderObject == null) {
        return;
      }

      setState(() {
        height = (renderObject as RenderBox).size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = this.height;

    if (height == null) {
      return SliverToBoxAdapter(
        child: Container(
          key: key,
          child: widget.background,
        ),
      );
    }

    return SliverAppBar(
      title: widget.title,
      actions: widget.actions,
      flexibleSpace: FlexibleSpaceBar(
        background: widget.background,
      ),
      centerTitle: widget.centerTitle,
      expandedHeight: height - MediaQuery.of(context).padding.top,
      pinned: widget.pinned,
    );
  }
}
