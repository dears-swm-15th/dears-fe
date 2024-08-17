import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum MemberRole {
  customer,
  weddingPlanner,
  ;

  static const defaultValue = customer;

  MemberRole get toggled {
    return switch (this) {
      customer => weddingPlanner,
      weddingPlanner => customer
    };
  }

  String get stompPrefix {
    return switch (this) {
      customer => "customer",
      weddingPlanner => "weddingplanner"
    };
  }
}
