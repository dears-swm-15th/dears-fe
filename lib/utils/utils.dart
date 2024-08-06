import 'package:flutter/material.dart';

extension AndThen<T> on T? {
  S? andThen<S>(S? Function(T) f) {
    final t = this;
    return t != null ? f(t) : null;
  }
}

bool isSameMinute(DateTime? dateA, DateTime? dateB) {
  return DateUtils.isSameDay(dateA, dateB) &&
      dateA?.hour == dateB?.hour &&
      dateA?.minute == dateB?.minute;
}
