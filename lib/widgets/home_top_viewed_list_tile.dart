import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeTopViewedListTile extends StatelessWidget {
  final int rank;
  final PortfolioOverview portfolio;

  const HomeTopViewedListTile({
    super.key,
    required this.rank,
    required this.portfolio,
  });

  @override
  Widget build(BuildContext context) {
    final minEstimate = number.format(portfolio.minEstimate);

    return GestureDetector(
      onTap: () => context.push("/details/${portfolio.id}"),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        // TODO: remove outer horizontal padding of the list
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Center(
                child: Text("$rank", style: titleSmall),
              ),
            ),
            const SizedBox(width: 8),
            CdnImage(
              portfolio.profileImageUrl,
              width: 54,
              height: 54,
              borderRadius: BorderRadius.circular(4),
              fallback: const Icon(DearsIcons.person, size: 28),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(portfolio.plannerName, style: titleSmall),
                    const SizedBox(width: 4),
                    Text(
                      portfolio.organization,
                      style: bodySmall.copyWith(color: gray600),
                    ),
                  ],
                ),
                Text("$minEstimate원~", style: titleSmall),
              ],
            ),
            const Spacer(),
            FavoriteToggleButton(portfolio.id),
          ],
        ),
      ),
    );
  }
}
