import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';

class RoleSelectionDialog extends StatelessWidget {
  final String colorTitle;
  final String normalTitle;
  final VoidCallback onAcceptPressed;

  const RoleSelectionDialog({
    super.key,
    required this.colorTitle,
    required this.normalTitle,
    required this.onAcceptPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              //TODO: Add the DearsIcons
              DearsIcons.info,
              size: 50,
              color: blue100,
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: colorTitle,
                    style: titleLarge.copyWith(color: blue500),
                  ),
                  TextSpan(
                    text: normalTitle,
                    style: titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '한 번 설정된 역할은 변경할 수 없습니다',
              style: TextStyle(
                color: gray600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: gray100),
                    onPressed: () {
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    },
                    child: Text(
                      '취소',
                      style: titleSmall.copyWith(color: gray800),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: FilledButton(
                    onPressed: onAcceptPressed,
                    child: const Text(
                      '네, 좋아요',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
