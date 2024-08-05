import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final NumberFormat number = NumberFormat("#,##0");
final NumberFormat rating = NumberFormat("0.0");

final DateFormat recent = RecentDateFormat();

class RecentDateFormat extends DateFormat {
  RecentDateFormat([super.newPattern, super.locale]);

  @override
  String format(DateTime date) {
    final now = DateTime.now();

    final diff = now.difference(date);
    if (diff.inHours == 0) {
      return "${diff.inMinutes}분 전";
    }

    if (DateUtils.isSameDay(date, now)) {
      final a = date.hour < 12 ? "오전" : "오후";
      final h = (date.hour + 12 - 1) % 12 + 1;
      final mm = date.minute.toString().padLeft(2, "0");
      return "$a $h:$mm";
    }

    final M = date.month;
    final d = date.day;
    if (date.year == now.year) {
      return "$M월 $d일";
    }

    final yy = date.year % 100;
    return "$yy. $M. $d.";
  }
}
