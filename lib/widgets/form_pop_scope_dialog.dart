import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showFormPopScopeDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning, size: 50),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  style: titleLarge,
                  children: [
                    TextSpan(text: "작성을 "),
                    TextSpan(text: "취소", style: TextStyle(color: blue500)),
                    TextSpan(text: "하고 나가시겠습니까?"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "작성하신 내용은 모두 지워집니다",
                style: TextStyle(color: gray600),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.pop(false),
                      style: FilledButton.styleFrom(
                        backgroundColor: gray100,
                        foregroundColor: gray800,
                      ),
                      child: const Text("취소"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.pop(true),
                      child: const Text("뒤로가기"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
