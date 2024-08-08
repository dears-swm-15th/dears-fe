import 'package:dears/models/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_list_provider.g.dart';

@riverpod
Future<List<Review>> reviewList(ReviewListRef ref, int portfolioId) {
  return Future.delayed(const Duration(seconds: 1), () {
    return [
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
        presignedWeddingPhotoUrls: [],
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  });
}
