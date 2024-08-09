import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/models/region.dart';
import 'package:dears/providers/recent_search_words_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_result_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> searchResult(
  SearchResultRef ref,
  String query,
) {
  ref.read(recentSearchWordsProvider.notifier).add(query);

  return Future.delayed(const Duration(seconds: 1), () {
    return const [
      PortfolioOverview(
        id: 1,
        organization: "웨딩드림",
        plannerName: "김지수",
        region: Region.gangnam,
        profileImageUrl: "",
        avgRating: 4.8,
        minEstimate: 250000,
        reviewCount: 10,
      ),
      PortfolioOverview(
        id: 1,
        organization: "로맨틱웨딩",
        plannerName: "박민아",
        region: Region.gangnam,
        profileImageUrl: "",
        avgRating: 4.5,
        minEstimate: 300000,
        reviewCount: 10,
      ),
      PortfolioOverview(
        id: 1,
        organization: "아이러브웨딩",
        plannerName: "이준호",
        region: Region.gangnam,
        profileImageUrl: "",
        avgRating: 5.0,
        minEstimate: 280000,
        reviewCount: 100,
      ),
      PortfolioOverview(
        id: 1,
        organization: "웨딩스토리",
        plannerName: "강수지",
        region: Region.gangnam,
        profileImageUrl: "",
        avgRating: 3.0,
        minEstimate: 220000,
        reviewCount: 1000,
      ),
      PortfolioOverview(
        id: 1,
        organization: "해피웨딩",
        plannerName: "최지윤",
        region: Region.gangnam,
        profileImageUrl: "",
        avgRating: 3.0,
        minEstimate: 290000,
        reviewCount: 10000,
      ),
    ];
  });
}
