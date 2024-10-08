import 'dart:typed_data';

import 'package:dears/models/accompany_type.dart';
import 'package:dears/models/region.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_portfolio_form_data.freezed.dart';

@freezed
class RegisterPortfolioFormData with _$RegisterPortfolioFormData {
  const factory RegisterPortfolioFormData({
    required String plannerName, // 플래너 이름
    required String companyName, // 업체명
    required String introduce, // 소개
    required Region? region, // 지역
    required AccompanyType type, // 유형
    required String cost, // 상담 비용
    required List<String> services, //제공 서비스 리스트
    required String content, // 상세 설명
    // TODO: handle case where images are too large to be held in memory
    // 프로필 이미지
    required (String, Uint8List) profileImage,
    // 포트폴리오 이미지
    required List<(String, Uint8List)> portfolioImages,
  }) = _RegisterPortfolioFormData;

  const RegisterPortfolioFormData._();

  bool get enabled =>
      plannerName.isNotEmpty &&
      companyName.isNotEmpty &&
      region != null &&
      cost.isNotEmpty &&
      content.isNotEmpty &&
      services.isNotEmpty &&
      profileImage.$1.isNotEmpty &&
      portfolioImages.isNotEmpty;
}
