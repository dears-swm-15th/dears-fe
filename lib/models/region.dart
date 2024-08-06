import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Region {
  chungdam("청담"),
  gangnam("강남"),
  ;

  final String name;

  const Region(this.name);

  @override
  String toString() => name;
}
