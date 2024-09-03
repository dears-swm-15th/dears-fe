import 'package:dears/providers/inquiry_form_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InquiryPage extends ConsumerWidget {
  const InquiryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(
      inquiryFormProvider.select((value) => value.enabled),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("문의하기"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "서비스를 이용하면서\n불편하신 점이 있으신가요?",
              style: titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "서비스 개선을 위해 자세한 내용을 남겨주시면 큰 도움이 됩니다",
              style: bodySmallLong.copyWith(
                color: gray600,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "문의 내용",
              style: bodySmall,
            ),
            const SizedBox(height: 10),
            TextField(
              style: bodySmallLong,
              decoration: const InputDecoration(
                hintText: "내용을 작성해주세요",
                hintStyle: TextStyle(color: gray600),
                hintMaxLines: 3,
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue500),
                ),
              ),
              maxLines: null,
              minLines: 3,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                ref.read(inquiryFormProvider.notifier).setContent(value);
              },
            ),
            const SizedBox(height: 16),
            const Spacer(),
            FilledButton(
              onPressed: () async {
                if (enabled) {
                  try {
                    //  TODO: 문의 제출 후 결과 스낵바 스타일 수정
                    await ref.watch(inquiryFormProvider.notifier).submit();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("정상적으로 제출되었습니다."),
                        ),
                      );
                      context.pop();
                    }
                  } catch (e) {
                    // 에러가 발생한 경우 처리
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("문의 제출 중 오류가 발생했습니다."),
                        ),
                      );
                    }
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("문의 내용을 입력해주세요"),
                      ),
                    );
                  }
                }
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 44),
              ),
              child: const Text('문의하기'),
            ),
          ],
        ),
      ),
    );
  }
}