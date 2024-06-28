import 'package:dears/widgets/review_keyword_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReviewInput extends HookWidget {
  const ReviewInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "웨딩플래너\n리뷰를 작성해주세요",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: "다른 사용자들에게 도움이 되도록 솔직하게 작성해주세요.",
              hintMaxLines: 3,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "내용을 입력해주세요";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const Text("해당하는 키워드를 선택해주세요"),
          const SizedBox(height: 8),
          const ReviewKeywordChips(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Form.of(context).validate();
                  },
                  child: const Text(
                    "리뷰 작성하기",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
