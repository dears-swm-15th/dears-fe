import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 흰색
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 상단 경고 아이콘
            const Icon(
              Icons.warning_amber_rounded,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 16),

            // 오류 제목
            const Text(
              "서비스에 문제가 발생했습니다",
              style: titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // 오류 메시지
            Text(
              "해당 오류는 관리자에게 전달됩니다\n더 좋은 서비스를 위해 신속히 개선하겠습니다",
              style: bodySmallLong.copyWith(color: gray600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // 이전으로 돌아가기 버튼
            Container(
              padding: const EdgeInsets.all(8),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 이전 화면으로 돌아가기
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: blue500), // 테두리 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // 버튼 라운드 처리
                  ),
                ),
                child: Text(
                  "이전으로 돌아가기",
                  style: captionLarge.copyWith(color: blue500, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
