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
}
