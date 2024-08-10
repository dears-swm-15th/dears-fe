import 'package:dears/models/region.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_overview.freezed.dart';
part 'portfolio_overview.g.dart';

@freezed
class PortfolioOverview with _$PortfolioOverview {
  const factory PortfolioOverview({
    required int id,
    required String organization,
    required String plannerName,
    required Region region,
    String? profileImageUrl,
    double? avgRating,
    int? minEstimate,
    int? reviewCount,
  }) = _PortfolioOverview;

  factory PortfolioOverview.fromJson(Map<String, dynamic> json) =>
      _$PortfolioOverviewFromJson(json);
}
