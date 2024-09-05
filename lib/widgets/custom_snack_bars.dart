import 'package:flutter/material.dart';

class CustomSnackBars {
  CustomSnackBars._();
  static void showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white), // 텍스트 색상 설정
      ),
      backgroundColor: Colors.red, // 스낵바 배경색 설정
      behavior: SnackBarBehavior.floating, // 플로팅 스타일 설정
      duration: const Duration(seconds: 3), // 스낵바 표시 시간
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showSuccess(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white), // 텍스트 색상 설정
      ),
      backgroundColor: Colors.green, // 스낵바 배경색 설정
      behavior: SnackBarBehavior.floating, // 플로팅 스타일 설정
      duration: const Duration(seconds: 3), // 스낵바 표시 시간
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
