import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum RadarKey {
  communication("의사소통"),
  budgetCompliance("예산 준수"),
  personalCustomization("개인 맞춤"),
  priceRationality("가격 합리성"),
  scheduleCompliance("일정 준수"),
  ;

  final String name;

  const RadarKey(this.name);

  @override
  String toString() => name;
}
