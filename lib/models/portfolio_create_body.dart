import 'package:dears/models/accompany_type.dart';
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
    //TODO: 연락처 받는 방법이 있어야할듯? 이를테면 kakao userinfo로 받는 방법
    @Default("010-1234-5678") String contactInfo, // 연락처
    required String profileImageUrl, // 프로필 이미지 URL
    required int consultingFee, // 상담비용
    required String description, // 상세 설명
    required AccompanyType accompanyType, // 동행 유형
    required List<String> services, // 제공 서비스 리스트
    required List<String> weddingPhotoUrls, // 웨딩 사진 URL 리스트
  }) = _PortfolioCreateBody;

  @override
  Map<String, dynamic> toJson();
}
