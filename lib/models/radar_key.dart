import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum RadarKey {
  communication,
  budgetCompliance,
  personalCustomization,
  priceRationality,
  scheduleCompliance,
  ;

  @override
  String toString() {
    return switch (this) {
      communication => "의사소통",
      budgetCompliance => "예산 준수",
      personalCustomization => "개인 맞춤",
      priceRationality => "가격 합리성",
      scheduleCompliance => "일정 준수",
    };
  }
}
