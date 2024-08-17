import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioListTile extends StatelessWidget {
  final PortfolioOverview portfolio;

  const PortfolioListTile(
    this.portfolio, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final reviewCount = number.format(portfolio.reviewCount);
    final avgRating = rating.format(portfolio.avgRating);
    final minEstimate = number.format(portfolio.minEstimate);

    return GestureDetector(
      onTap: () => context.push("/details/${portfolio.id}"),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 100,
        child: Row(
          children: [
            CdnImage(
              portfolio.profileImageUrl,
              width: 84,
              height: 84,
              borderRadius: BorderRadius.circular(4),
              fallback: const Icon(DearsIcons.person, size: 32),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      portfolio.plannerName,
                      style: titleSmall,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      portfolio.organization,
                      style: bodySmall.copyWith(color: gray600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "리뷰($reviewCount)",
                      style: captionLarge.copyWith(color: gray600),
                    ),
                    const SizedBox(width: 2),
                    const Icon(DearsIcons.star, size: 16, color: yellow),
                    const SizedBox(width: 2),
                    Text(
                      avgRating,
                      style: captionLarge.copyWith(color: gray800),
                    ),
                  ],
                ),
                const Spacer(),
                Text("$minEstimate원~", style: titleSmall),
                const SizedBox(height: 4),
              ],
            ),
            const Spacer(),
            const FavoriteToggleButton(initialFavorite: true),
          ],
        ),
      ),
    );
  }
}
