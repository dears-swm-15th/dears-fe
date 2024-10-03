import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_create_response.freezed.dart';
part 'portfolio_create_response.g.dart';

@Freezed(toJson: false)
class PortfolioCreateResponse with _$PortfolioCreateResponse {
  const factory PortfolioCreateResponse({
    required String presignedProfileImageUrl,
    required List<String> presignedWeddingPhotoUrls,
  }) = _PortfolioCreateResponse;

  factory PortfolioCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfolioCreateResponseFromJson(json);
}
