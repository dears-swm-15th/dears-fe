import 'dart:io';

import 'package:dears/clients/file_client.dart';
import 'package:dears/models/radar_key.dart';
import 'package:dears/models/review_create_body.dart';
import 'package:dears/models/review_form_data.dart';
import 'package:dears/models/review_type.dart';
import 'package:dears/providers/review_client_provider.dart';
import 'package:dears/providers/review_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_form_provider.g.dart';

@riverpod
class ReviewForm extends _$ReviewForm {
  @override
  ReviewFormData build(int portfolioId) {
    return ReviewFormData(
      enabled: false,
      type: ReviewType.values[0],
      rating: 0,
      tags: List.filled(reviewKeywords.length, false),
      content: "",
      images: [],
    );
  }

  bool get _enabled => state.rating != 0 && state.content.isNotEmpty;

  void setType(ReviewType type) {
    state = state.copyWith(type: type);
  }

  void setRating(int rating) {
    state = state.copyWith(rating: rating);
    state = state.copyWith(enabled: _enabled);
  }

  void setTags(List<bool> tags) {
    state = state.copyWith(tags: tags);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
    state = state.copyWith(enabled: _enabled);
  }

  void setImages(List<String> images) {
    state = state.copyWith(images: images);
  }

  Future<void> submit(int portfolioId) async {
    final reviewClient = await ref.read(reviewClientProvider.future);

    final response = await reviewClient.create(
      data: ReviewCreateBody(
        portfolioId: portfolioId,
        rating: state.rating,
        tags: [
          for (final (i, selected) in state.tags.indexed)
            if (selected) reviewKeywords[i],
        ],
        content: state.content,
        weddingPhotoUrls: [
          for (final (i, _) in state.images.indexed) "$i",
        ],

        // TODO: implement to get data below from UI
        estimate: 300000,
        radar: {
          for (final key in RadarKey.values) key: 5,
        },
      ),
    );
    await Future.wait([
      for (final (i, url) in response.presignedWeddingPhotoUrls.indexed)
        fileClient.upload(
          presignedUrl: url,
          file: File(state.images[i]),
        ),
    ]);

    ref.invalidateSelf();
    ref.invalidate(reviewListProvider(portfolioId));
  }
}