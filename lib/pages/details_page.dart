import 'package:dears/domains/portfolio/portfolio.dart';
import 'package:flutter/material.dart';

const _mockPortfolio = Portfolio(
  name: "이름",
  organization: "소속",
  region: "서울",
  introduction: "안녕하세요",
  officeHours: "09:00 ~ 18:00",
  contactInfo: "010-1234-5678",
);

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(),
                  Text(_mockPortfolio.name),
                  Text(_mockPortfolio.organization),
                ],
              ),
            ),
            const Divider(),
            Column(
              children: <(String, String)>[
                ("활동 지역", _mockPortfolio.region),
                ("상담 가능 시간", _mockPortfolio.officeHours),
                ("휴무일", "토, 일, 공휴일"),
              ]
                  .map(
                    (e) => Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(e.$1),
                        ),
                        Text(e.$2),
                      ],
                    ),
                  )
                  .toList(),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(_mockPortfolio.introduction),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("전화"),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("카톡"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
