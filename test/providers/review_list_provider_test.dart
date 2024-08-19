import 'package:dears/models/review.dart';
import 'package:dears/providers/review_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  test("reviewListProvider test", () {
    const portfolioId = 42;

    final list = [
      Review(
        id: 1,
        portfolioId: portfolioId,
        reviewerName: "아이디",
        content:
            "세세한 부분까지 꼼꼼히 설명해주시고, 우리에게 딱 맞는 맞춤 웨딩 플랜을 제안해주셔서 감사했어요. 앞으로 웨딩 준비하는 게 정말 기대돼요!",
        isProvided: true,
        rating: 2.5,
        estimate: 100000,
        tags: ["동행", "신혼여행"],
        weddingPhotoUrls: [],
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];

    final container = createContainer(
      overrides: [
        reviewListProvider(portfolioId).overrideWith((ref) async => list),
      ],
    );

    expectLater(
      container.read(reviewListProvider(portfolioId).future),
      completion(isNotEmpty),
    );
  });
}
