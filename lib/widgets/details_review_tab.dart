import 'package:dears/widgets/review_list_tile.dart';
import 'package:flutter/material.dart';

class DetailsReviewTab extends StatelessWidget {
  const DetailsReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          SizedBox(height: 16),
          Text(
            "리뷰",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ReviewListTile(),
          SizedBox(height: 8),
          ReviewListTile(),
          SizedBox(height: 8),
          ReviewListTile(),
        ],
      ),
    );
  }
}
