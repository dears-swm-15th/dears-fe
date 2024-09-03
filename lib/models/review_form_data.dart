import 'package:dears/models/review_type.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_form_data.freezed.dart';

const List<String> reviewKeywords = [
  "동행",
  "비동행",
  "예물",
  "신혼여행",
  "혼수",
  "웨딩홀",
];

@freezed
class ReviewFormData with _$ReviewFormData {
  const factory ReviewFormData({
    required bool enabled,
    required ReviewType type,
    required int rating,
    required List<bool> tags,
    required String content,

    // TODO: handle case where images are too large to be held in memory
    required List<(String, Uint8List)> images,
  }) = _ReviewFormData;
}
