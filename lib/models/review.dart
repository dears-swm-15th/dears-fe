import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required int portfolioId,
    @Default("") String reviewerName,
    required String content,
    @Default(false) bool isProvided,
    required double rating,
    required int estimate,
    @Default([]) List<String> tags,
    required List<String> weddingPhotoUrls,
    required DateTime createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
