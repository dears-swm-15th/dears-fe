import 'package:dears/models/accompany_type.dart';
import 'package:dears/models/image_data.dart';
import 'package:dears/models/region.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_create_form_data.freezed.dart';

@freezed
class PortfolioCreateFormData with _$PortfolioCreateFormData {
  const factory PortfolioCreateFormData({
    required String plannerName, // 플래너 이름
    required String companyName, // 업체명
    required String introduce, // 소개
    required Region region, // 지역
    required AccompanyType type, // 유형
    required int? cost, // 상담 비용
    required List<String> services, //제공 서비스 리스트
    required String content, // 상세 설명
    required ImageData? profileImage, // 프로필 이미지
    required List<ImageData> portfolioImages, // 포트폴리오 이미지
  }) = _PortfolioCreateFormData;

  const PortfolioCreateFormData._();

  bool get enabled =>
      plannerName.isNotEmpty &&
      companyName.isNotEmpty &&
      introduce.isNotEmpty &&
      cost != null &&
      content.isNotEmpty &&
      services.isNotEmpty &&
      profileImage != null &&
      portfolioImages.isNotEmpty;
}
