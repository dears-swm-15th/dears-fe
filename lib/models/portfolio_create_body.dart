import 'package:dears/models/region.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_create_body.freezed.dart';
part 'portfolio_create_body.g.dart';

@Freezed(toJson: true)
class PortfolioCreateBody with _$PortfolioCreateBody {
  const factory PortfolioCreateBody({
    required String organization, // 회사명
    required String plannerName, // 플래너 이름
    required Region region, // 지역 (예: "GANGNAM")
    required String introduction, // 소개
    @Default("010-1234-5678") String contactInfo, // 연락처
    required String profileImageUrl, // 프로필 이미지 URL
    required int consultingFee, // 상담비용
    required String description, // 설명
    // required double ratingSum, // 평점 총합
    // required int ratingCount, // 평점 수
    // required int avgEstimate, // 평균 견적
    // required int estimateSum, // 견적 총합
    // required int minEstimate, // 최소 견적
    required List<String> services, // 제공 서비스 리스트
    required List<String> weddingPhotoUrls, // 웨딩 사진 URL 리스트
    // required Map<String, double> avgRadar, // 레이더 점수
    // required int radarCount,
  }) = _PortfolioCreateBody;

  @override
  Map<String, dynamic> toJson();
}
