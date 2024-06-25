import 'package:dears/domains/portfolio/portfolio.dart';
import 'package:dears/widgets/favorite_count_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PortfolioListTile extends StatelessWidget {
  final Portfolio portfolio;

  const PortfolioListTile(
    this.portfolio, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/details/${portfolio.id}");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portfolio.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(portfolio.organization),
                      const Spacer(),
                      const Text(
                        "250,000원~",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const FavoriteCountToggleButton(
              initialFavorite: true,
              initialCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
