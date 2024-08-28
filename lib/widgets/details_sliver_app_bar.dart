import 'package:dears/models/portfolio.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/details_background_carousel.dart';
import 'package:dears/widgets/details_tag_box.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';

class DetailsSliverAppBar extends StatefulWidget {
  final Portfolio portfolio;

  const DetailsSliverAppBar(
    this.portfolio, {
    super.key,
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
      final size = key.currentContext?.size;
      if (size == null) {
        return;
      }

      setState(() {
        height = size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = this.height;

    final avgRating = rating.format(widget.portfolio.avgRating);
    final tags = ["여성", "동행"];

    final background = Column(
      children: [
        DetailsBackgroundCarousel(widget.portfolio),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.portfolio.name, style: titleLarge),
                      const SizedBox(width: 8),
                      Text(
                        widget.portfolio.organization,
                        style: bodySmall.copyWith(color: gray600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(DearsIcons.star, size: 16, color: yellow),
                      Text(
                        avgRating,
                        style: captionLarge.copyWith(color: gray800),
                      ),
                      ...List.generate(tags.length, (index) {
                        final tag = tags[index];
                        return DetailsTagBox(tag);
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.portfolio.introduction,
                    style: bodySmallLong.copyWith(color: gray800),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -50,
              right: 24,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: white,
                child: CdnImage.circle(
                  widget.portfolio.profileImageUrl,
                  dimension: 96,
                  fallback: const Icon(DearsIcons.person, size: 60),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    if (height == null) {
      return SliverToBoxAdapter(
        child: Container(
          key: key,
          child: background,
        ),
      );
    }

    final title = Text("${widget.portfolio.name} 웨딩플래너");

    final actions = [
      FavoriteToggleButton(widget.portfolio.id),
      const SizedBox(width: 8),
    ];

    final topPadding = MediaQuery.of(context).padding.top;
    final collapsedHeight = topPadding + toolbarHeight;

    return SliverAppBar(
      pinned: true,
      expandedHeight: height - topPadding,
      toolbarHeight: toolbarHeight,
      actions: actions,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final isCollapsed = constraints.biggest.height == collapsedHeight;

          return FlexibleSpaceBar(
            title: isCollapsed ? title : null,
            background: background,
          );
        },
      ),
    );
  }
}
