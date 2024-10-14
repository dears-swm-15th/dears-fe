import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum MemberRole {
  customer,
  weddingPlanner,
  ;

  static const defaultValue = customer;

  String get apiPrefix {
    return switch (this) {
      customer => "customer",
      weddingPlanner => "weddingplanner"
    };
  }

  @override
  String toString() {
    return switch (this) {
      customer => "예비 신혼부부",
      weddingPlanner => "웨딩플래너",
    };
  }
}
