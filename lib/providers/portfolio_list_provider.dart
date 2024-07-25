import 'package:dears/models/portfolio/portfolio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_list_provider.g.dart';

@riverpod
List<Portfolio> portfolioList(PortfolioListRef ref) {
  return const [
    Portfolio(
      id: 1,
      name: "이름1",
      organization: "소속1",
      region: "지역1",
      introduction: "안녕하세요",
      officeHours: "09:00 ~ 18:00",
      contactInfo: "010-1234-5678",
    ),
    Portfolio(
      id: 2,
      name: "이름2",
      organization: "소속2",
      region: "지역2",
      introduction: "안녕하세요",
      officeHours: "09:00 ~ 18:00",
      contactInfo: "010-1234-5678",
    ),
    Portfolio(
      id: 3,
      name: "이름3",
      organization: "소속3",
      region: "지역3",
      introduction: "안녕하세요",
      officeHours: "09:00 ~ 18:00",
      contactInfo: "010-1234-5678",
    ),
  ];
}
