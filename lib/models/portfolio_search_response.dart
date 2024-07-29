import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_search_response.freezed.dart';
part 'portfolio_search_response.g.dart';

@freezed
class PortfolioSearchResponse with _$PortfolioSearchResponse {
  const factory PortfolioSearchResponse({
    required int id,
    required String organization,
    required String plannerName,
    required double ratingSum,
    required int ratingCount,
    required int minEstimate,
  }) = _PortfolioSearchResponse;

  const PortfolioSearchResponse._();

  double get rating => ratingSum / ratingCount;

  factory PortfolioSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfolioSearchResponseFromJson(json);
}
