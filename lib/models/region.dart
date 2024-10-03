import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Region {
  seoul("서울"),
  incheon("인천"),
  gyeonggi("경기"),
  ;

  final String name;

  const Region(this.name);

  @override
  String toString() => name;
}
