import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AccompanyType {
  accompany("동행"),
  notAccompany("비동행"),
  hybrid("동행/비동행");

  final String label;

  const AccompanyType(this.label);

  static const defaultValue = accompany;
}
