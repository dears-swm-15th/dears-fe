import 'package:dears/models/review.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/cdn_image.dart';
import 'package:dears/widgets/review_tag_box.dart';
import 'package:dears/widgets/star_rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewListTile extends StatelessWidget {
  final Review review;

  const ReviewListTile(
    this.review, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createdAt = recent.format(review.createdAt);
    final isProvided =
        review.isProvided ? "웨딩플래너를 통해 제공받은 후기입니다" : "직접 작성한 후기입니다";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: gray100),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(review.reviewerName, style: titleMedium),
              const Spacer(),
              StarRatingBar(review.rating),
              const SizedBox(width: 10),
              Text(
                createdAt,
                style: captionLarge.copyWith(color: gray600),
              ),
            ],
          ),
          if (review.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(review.tags.length, (index) {
                final tag = review.tags[index];
                return ReviewTagBox(tag);
              }),
            ),
          ],
          const SizedBox(height: 12),
          Text(review.content, style: bodySmall),
          if (review.weddingPhotoUrls.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.weddingPhotoUrls.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CdnImage(
                    review.weddingPhotoUrls[index],
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.circular(4),
                    fallback: const Icon(Icons.image),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              isProvided,
              style: captionLarge.copyWith(color: gray600),
            ),
          ),
        ],
      ),
    );
  }
}
