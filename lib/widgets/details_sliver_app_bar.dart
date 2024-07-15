import 'package:flutter/material.dart';

class DetailsSliverAppBar extends StatefulWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? background;

  const DetailsSliverAppBar({
    super.key,
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
  void didUpdateWidget(DetailsSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateHeight();
  }

  void updateHeight() {
    // Gets the new height and updates the sliver app bar.
    // Needs to be called after the last frame has been rebuild,
    // otherwise this will throw an error.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        return;
      }

      setState(() {
        height = renderBox.size.height;
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
      pinned: true,
      expandedHeight: height - MediaQuery.of(context).padding.top,
      actions: widget.actions,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final isCollapsed = constraints.biggest.height ==
              MediaQuery.of(context).padding.top + kToolbarHeight;

          return FlexibleSpaceBar(
            title: isCollapsed ? widget.title : null,
            background: widget.background,
          );
        },
      ),
    );
  }
}
