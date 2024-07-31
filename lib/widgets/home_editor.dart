import 'package:flutter/material.dart';

class HomeEditor extends StatelessWidget {
  const HomeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 120,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 168,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 168,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 120,
                color: Colors.grey,
              ),
              const SizedBox(height: 4),
              const Text(
                "웨딩 전문 에디터가 알려주는 \n웨딩 준비 전 읽어야 할 꿀팁!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
