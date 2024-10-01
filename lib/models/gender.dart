import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Gender {
  man("남성"),
  woman("여성"),
  ;

  final String name;

  const Gender(this.name);

  @override
  String toString() => name;
}
