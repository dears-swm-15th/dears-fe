import 'dart:typed_data';

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
      type: ReviewType.values[0],
      rating: 0,
      tags: List.filled(reviewKeywords.length, false),
      content: "",
      images: [],
      consultingFee: null,
      estimate: null,
      radarIndexes: {},
    );
  }

  void setType(ReviewType type) {
    state = state.copyWith(type: type);
  }

  void setRating(int rating) {
    state = state.copyWith(rating: rating);
  }

  void setTags(List<bool> tags) {
    state = state.copyWith(tags: tags);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void addImages(Iterable<(String, Uint8List)> images) {
    state = state.copyWith(images: [...state.images, ...images]);
  }

  void removeImageAt(int index) {
    state = state.copyWith(images: [...state.images]..removeAt(index));
  }

  void setConsultingFee(int? consultingFee) {
    state = state.copyWith(consultingFee: consultingFee);
  }

  void setEstimate(int? estimate) {
    state = state.copyWith(estimate: estimate);
  }

  void setRadarIndex(RadarKey key, int? value) {
    if (value != null) {
      state = state.copyWith(
        radarIndexes: {...state.radarIndexes, key: value},
      );
    } else {
      state = state.copyWith(
        radarIndexes: {...state.radarIndexes}..remove(key),
      );
    }
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
          for (final image in state.images) image.$1,
        ],
        consultingFee: state.consultingFee,
        estimate: state.estimate,
        radar: {
          for (final MapEntry(:key, :value) in state.radarIndexes.entries)
            key: 2 * value + 1,
        },
      ),
    );
    await Future.wait([
      for (final (i, url) in response.presignedWeddingPhotoUrls.indexed)
        fileClient.upload(
          presignedUrl: url,
          file: state.images[i].$2,
        ),
    ]);

    ref.invalidateSelf();
    ref.invalidate(reviewListProvider(portfolioId));
  }
}
