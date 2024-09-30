import 'package:dears/models/radar_key.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_create_body.freezed.dart';
part 'review_create_body.g.dart';

@Freezed(toJson: true)
class ReviewCreateBody with _$ReviewCreateBody {
  const factory ReviewCreateBody({
    required int portfolioId,
    required int rating,
    required List<String> tags,
    required String content,
    required List<String> weddingPhotoUrls,
    int? consultingFee,
    int? estimate,
    required Map<RadarKey, int> radar,
  }) = _ReviewCreateBody;

  @override
  Map<String, dynamic> toJson();
}
