import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/search_result_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  test("searchResultProvider test", () {
    const query = "query";

    const result = [
      PortfolioOverview(
        id: 1,
        organization: "웨딩드림",
        plannerName: "김지수",
        profileImageUrl: "",
        avgRating: 4.8,
        minEstimate: 250000,
        reviewCount: 10,
      ),
      PortfolioOverview(
        id: 1,
        organization: "로맨틱웨딩",
        plannerName: "박민아",
        profileImageUrl: "",
        avgRating: 4.5,
        minEstimate: 300000,
        reviewCount: 10,
      ),
      PortfolioOverview(
        id: 1,
        organization: "아이러브웨딩",
        plannerName: "이준호",
        profileImageUrl: "",
        avgRating: 5.0,
        minEstimate: 280000,
        reviewCount: 100,
      ),
      PortfolioOverview(
        id: 1,
        organization: "웨딩스토리",
        plannerName: "강수지",
        profileImageUrl: "",
        avgRating: 3.0,
        minEstimate: 220000,
        reviewCount: 1000,
      ),
      PortfolioOverview(
        id: 1,
        organization: "해피웨딩",
        plannerName: "최지윤",
        profileImageUrl: "",
        avgRating: 3.0,
        minEstimate: 290000,
        reviewCount: 10000,
      ),
    ];

    final container = createContainer(
      overrides: [
        searchResultProvider(query).overrideWith((ref) {
          return Future.delayed(const Duration(seconds: 1), () => result);
        }),
      ],
    );

    expectLater(
      container.read(searchResultProvider(query).future),
      completion(isNotEmpty),
    );
  });
}
