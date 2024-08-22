import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_create_response.freezed.dart';
part 'review_create_response.g.dart';

@Freezed(toJson: false)
class ReviewCreateResponse with _$ReviewCreateResponse {
  const factory ReviewCreateResponse({
    required List<String> presignedWeddingPhotoUrls,
  }) = _ReviewCreateResponse;

  factory ReviewCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewCreateResponseFromJson(json);
}
