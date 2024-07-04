import 'package:flutter/material.dart';

class DetailsIntroductionTab extends StatelessWidget {
  const DetailsIntroductionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 36),
          const Text(
            "상세 정보",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              SizedBox(
                width: 80,
                child: Text("활동지역"),
              ),
              SizedBox(width: 20),
              Text("서울 전체"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(
                width: 80,
                child: Text("상담가능시간"),
              ),
              SizedBox(width: 20),
              Text("오전 9:00 ~ 오후 6:00"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(
                width: 80,
                child: Text("휴무일"),
              ),
              SizedBox(width: 20),
              Text("매주 월요일"),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            "제공 서비스",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.check, size: 20),
              SizedBox(width: 10),
              Text("서비스1"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.check, size: 20),
              SizedBox(width: 10),
              Text("서비스2"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.check, size: 20),
              SizedBox(width: 10),
              Text("서비스3"),
            ],
          ),
          const SizedBox(height: 40),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: "해당 웨딩플래너 진행 시,\n"),
                TextSpan(text: "평균가는 "),
                TextSpan(
                  text: "375,000원",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(text: " 입니다"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 76,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("최저가"),
                      SizedBox(height: 8),
                      Text(
                        "200,000원~",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 76,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("상담비 별도"),
                      SizedBox(height: 8),
                      Text(
                        "30,000원",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "실제 가격은 상담 후 계약에 따라 달라질 수 있습니다. 실제 가격은 상담 후 계약에 따라 달라질 수 있습니다.",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "전하고 싶은 말",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "저희 웨딩플래너는 최신 웨딩 트렌드와 정보를 항상 주시하고 있으며, 고객님의 개성과 취향을 반영한 맞춤형 웨딩 계획을 제안해 드립니다. 또한 신뢰할 수 있는 협력업체들과의 네트워크를 통해 최고의 서비스를 제공하고 있습니다.\n\n고객님의 소중한 웨딩을 위해 저희와 함께 행복한 결혼 생활의 시작을 준비해 보시기 바랍니다.",
            style: TextStyle(fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10,
                (index) {
                  return Container(
                    width: 100,
                    height: 100,
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
        ],
      ),
    );
  }
}
