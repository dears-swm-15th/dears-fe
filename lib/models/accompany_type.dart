import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AccompanyType {
  accompany("동행"),
  notAccompany("비동행"),
  hybrid("동행/비동행");

  final String name;

  const AccompanyType(this.name);

  static const defaultValue = accompany;

  @override
  String toString() => name;
}
