import 'package:dears/models/portfolio.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/details_chat_button.dart';
import 'package:flutter/material.dart';

class DetailsBottomBar extends StatelessWidget {
  final Portfolio portfolio;

  const DetailsBottomBar(
    this.portfolio, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final minEstimate = number.format(portfolio.minEstimate);
    final avgEstimate = number.format(portfolio.avgEstimate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 144,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$minEstimate원~", style: titleMedium),
                Text(
                  "평균 $avgEstimate원",
                  style: bodySmall.copyWith(color: gray600),
                ),
              ],
            ),
          ),
          Expanded(
            child: DetailsChatButton(portfolio.id),
          ),
        ],
      ),
    );
  }
}
