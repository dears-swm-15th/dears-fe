import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomFormatter<T> {
  final String Function(T value) format;

  const CustomFormatter(this.format);

  String call(T value) => format(value);
}

final NumberFormat _number = NumberFormat("#,##0");

final CustomFormatter<int?> number = CustomFormatter((value) {
  if (value == null) {
    return "-";
  }
  return _number.format(value);
});

final NumberFormat _rating = NumberFormat("0.0");

final CustomFormatter<double?> rating = CustomFormatter((value) {
  if (value == null) {
    return "-";
  }
  return _rating.format(value);
});

final CustomFormatter<int> count = CustomFormatter((value) {
  return value > 999 ? "999+" : "$value";
});

final CustomFormatter<DateTime> time = CustomFormatter((date) {
  final a = date.hour < 12 ? "오전" : "오후";
  final h = (date.hour + 12 - 1) % 12 + 1;
  final mm = date.minute.toString().padLeft(2, "0");
  return "$a $h:$mm";
});

final CustomFormatter<DateTime> recent = CustomFormatter((date) {
  final now = DateTime.now();

  final diff = now.difference(date);
  if (diff.inMinutes == 0) {
    return "방금";
  }
  if (diff.inHours == 0) {
    return "${diff.inMinutes}분 전";
  }

  if (DateUtils.isSameDay(date, now)) {
    return time.format(date);
  }

  final M = date.month;
  final d = date.day;
  if (date.year == now.year) {
    return "$M월 $d일";
  }

  final yy = date.year % 100;
  return "$yy. $M. $d.";
});

const List<String> _weekdays = ["일", "월", "화", "수", "목", "금", "토"];

final CustomFormatter<DateTime> fullDate = CustomFormatter((date) {
  final now = DateTime.now();

  final M = date.month;
  final d = date.day;
  final E = _weekdays[date.weekday % 7];
  if (date.year == now.year) {
    return "$M월 $d일 ($E)";
  }

  final yyyy = date.year;
  return "$yyyy년 $M월 $d일 ($E)";
});

final CustomFormatter<String> search = CustomFormatter((value) {
  return value.trim().replaceAll(RegExp(r'\s+'), " ").toLowerCase();
});
