import 'package:dears/models/radar_key.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required String reviewerName,
    required String content,
    required bool isProvided,
    required double rating,
    required int estimate,
    required List<String> tags,
    required List<String> weddingPhotoUrls,
    required Map<RadarKey, double> radar,
    required List<String> presignedWeddingPhotoUrls,
    required int portfolioId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
