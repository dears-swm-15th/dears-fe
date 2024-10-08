import 'package:dears/models/radar_key.dart';
import 'package:dears/models/region.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio.freezed.dart';
part 'portfolio.g.dart';

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required int id,
    required String organization,
    required String plannerName,
    required Region region,
    required String introduction,
    required String contactInfo,
    String? profileImageUrl,
    required String description,
    int? consultingFee,
    double? avgRating,
    int? avgEstimate,
    int? minEstimate,
    required List<String> services,
    required List<String> weddingPhotoUrls,
    @Default({}) Map<RadarKey, double> avgRadar,
    String? presignedProfileImageUrl,
    required List<String> presignedWeddingPhotoUrls,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Portfolio;

  const Portfolio._();

  String get name => plannerName;

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
