import 'package:dears/models/portfolio.dart';
import 'package:dears/utils/formats.dart';
import 'package:dears/utils/icons.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/radar_chart.dart';
import 'package:flutter/material.dart';

class DetailsIntroductionTab extends StatelessWidget {
  final Portfolio portfolio;

  const DetailsIntroductionTab(
    this.portfolio, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const services = ["서비스1", "서비스2", "서비스3"];

    final avgEstimate = number.format(portfolio.avgEstimate);
    final minEstimate = number.format(portfolio.minEstimate);
    final consultingFee = number.format(portfolio.consultingFee);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: gray100),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      DearsIcons.location_pin,
                      size: 16,
                      color: gray600,
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 80,
                      child: Text(
                        "활동지역",
                        style: titleSmall.copyWith(color: gray600),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text("${portfolio.region}", style: bodySmall),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      DearsIcons.clock,
                      size: 16,
                      color: gray600,
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 80,
                      child: Text(
                        "평균응답시간",
                        style: titleSmall.copyWith(color: gray600),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text("30분 이내", style: bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("제공 서비스", style: titleMedium),
          const SizedBox(height: 16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final service = services[index];
              return Row(
                children: [
                  const Icon(DearsIcons.check, size: 20, color: blue500),
                  const SizedBox(width: 10),
                  Text(
                    service,
                    style: bodySmall.copyWith(color: gray800),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              style: titleLarge,
              children: [
                const TextSpan(text: "해당 웨딩플래너 진행 시,\n"),
                const TextSpan(text: "평균가는 "),
                TextSpan(
                  text: "$avgEstimate원",
                  style: const TextStyle(color: blue500),
                ),
                const TextSpan(text: " 입니다"),
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
                    border: Border.all(color: gray100),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "최저가",
                        style: titleSmall.copyWith(color: blue500),
                      ),
                      const SizedBox(height: 8),
                      Text("$minEstimate원~", style: titleMedium),
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
                    border: Border.all(color: gray100),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "상담비 별도",
                        style: titleSmall.copyWith(color: red),
                      ),
                      const SizedBox(height: 8),
                      Text("$consultingFee원", style: titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: blue50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: Row(
                    children: [
                      const Icon(DearsIcons.info, size: 18, color: blue500),
                      const SizedBox(width: 2),
                      Text(
                        "알려드립니다",
                        style: titleSmall.copyWith(color: blue500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "평균가는 플래너 고용 비용과 스드메 비용이 포함된 가격입니다",
                    style: captionLarge.copyWith(color: gray800),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("상세 설명", style: titleMedium),
          const SizedBox(height: 16),
          Text(portfolio.description, style: bodyMediumLong),
          const SizedBox(height: 40),
          const Text("예비 신혼부부들의 평가", style: titleMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: boxShadow,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 248,
                  child: RadarChart(portfolio.avgRadar),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("평가 하러가기"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
