import 'package:dears/domains/portfolio/portfolio.dart';
import 'package:dears/widgets/favorite_count_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BestPortfolioListTitle extends StatelessWidget {
  final Portfolio portfolio;

  const BestPortfolioListTitle(
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
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${portfolio.id}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                portfolio.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(portfolio.organization),
                            ],
                          ),
                          const Text(
                            "250,000원~",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
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
