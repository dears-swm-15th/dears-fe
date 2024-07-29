import 'package:dears/models/profile.dart';
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
    required String profileImageUrl,
    required String description,
    required int consultingFee,
    required double ratingSum,
    required int ratingCount,
    required int estimateSum,
    required int estimateCount,
    required int minEstimate,
    required List<String> services,
    required Profile weddingPlannerPortfolioResponse,
    required List<String> weddingPhotoUrls,
    required Map<RadarKey, double> avgRadar,
    required int radarCount,
    required String presignedProfileImageUrl,
    required List<String> presignedWeddingPhotoUrls,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Portfolio;

  const Portfolio._();

  String get name => plannerName;

  double get rating => ratingSum / ratingCount;
  double get estimate => estimateSum / estimateCount;

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
