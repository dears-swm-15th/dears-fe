import 'package:dears/widgets/category_text_box.dart';
import 'package:dears/widgets/star_rating_bar.dart';
import 'package:flutter/material.dart';

class ReviewListTile extends StatelessWidget {
  const ReviewListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "아이디",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  StarRatingBar(rating: 5),
                  SizedBox(width: 10),
                  Text("24.06.25"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              CategoryTextBox(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                backgroundColor: Colors.grey,
                category: "동행",
                textStyle: TextStyle(fontSize: 12, color: Colors.white),
              ),
              CategoryTextBox(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                backgroundColor: Colors.grey,
                category: "신혼여행",
                textStyle: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "세세한 부분까지 꼼꼼히 설명해주시고, 우리에게 딱 맞는 맞춤 웨딩 플랜을 제안해주셔서 감사했어요. 앞으로 웨딩 준비하는 게 정말 기대돼요!",
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                3,
                (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              "직접 작성한 후기입니다",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
