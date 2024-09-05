import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  const ErrorBottomSheet({super.key, required this.title, required this.message, required this.buttonText, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
              children: [
                const Icon(
                  Icons.warning_amber_rounded, // 경고 아이콘
                  size: 80,
                  color: Colors.red,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 15,
                    color: gray600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onButtonPressed,
              child: Text(
                buttonText,
                style: titleSmall.copyWith(color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
