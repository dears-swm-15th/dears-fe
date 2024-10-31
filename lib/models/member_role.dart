import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum MemberRole {
  customer("예비 신혼부부"),
  weddingPlanner("웨딩플래너"),
  ;

  final String label;

  const MemberRole(this.label);

  static const defaultValue = customer;

  String get apiPrefix {
    return switch (this) {
      customer => "customer",
      weddingPlanner => "weddingplanner"
    };
  }
}
