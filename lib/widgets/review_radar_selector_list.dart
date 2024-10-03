import 'package:dears/models/radar_key.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/review_radar_selector.dart';
import 'package:flutter/widgets.dart';

class ReviewRadarSelectorList extends StatelessWidget {
  final int portfolioId;

  const ReviewRadarSelectorList(
    this.portfolioId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("웨딩플래너 만족도 평가", style: titleLarge),
        const SizedBox(height: 16),
        ReviewRadarSelector(
          portfolioId: portfolioId,
          radarKey: RadarKey.communication,
          title: "의사소통",
          subtitle: "웨딩 플래너와의 소통은 얼마나 원활했나요?",
          lowLabel: "불친절해요",
          middleLabel: "보통이에요",
          highLabel: "만족해요",
        ),
        const SizedBox(height: 30),
        ReviewRadarSelector(
          portfolioId: portfolioId,
          radarKey: RadarKey.personalCustomization,
          title: "개인맞춤",
          subtitle: "원하는 스타일과 요구가 잘 반영되었나요?",
          lowLabel: "그렇지 않아요",
          middleLabel: "보통이에요",
          highLabel: "만족해요",
        ),
        const SizedBox(height: 30),
        ReviewRadarSelector(
          portfolioId: portfolioId,
          radarKey: RadarKey.priceRationality,
          title: "가격합리성",
          subtitle: "제공된 서비스의 가격이 합리적이었나요?",
          lowLabel: "그렇지 않아요",
          middleLabel: "보통이에요",
          highLabel: "합리적이에요",
        ),
        const SizedBox(height: 30),
        ReviewRadarSelector(
          portfolioId: portfolioId,
          radarKey: RadarKey.budgetCompliance,
          title: "예산준수",
          subtitle: "예산을 얼마나 잘 지켜주셨나요?",
          lowLabel: "그렇지 않아요",
          middleLabel: "보통이에요",
          highLabel: "만족해요",
        ),
        const SizedBox(height: 30),
        ReviewRadarSelector(
          portfolioId: portfolioId,
          radarKey: RadarKey.scheduleCompliance,
          title: "일정준수",
          subtitle: "약속한 일정대로 진행이 잘 되었나요?",
          lowLabel: "그렇지 않아요",
          middleLabel: "보통이에요",
          highLabel: "만족해요",
        ),
      ],
    );
  }
}
