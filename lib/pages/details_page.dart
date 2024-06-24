import 'package:dears/providers/portfolio_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailsPage extends ConsumerWidget {
  final int plannerId;

  const DetailsPage({
    super.key,
    required this.plannerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioList = ref.watch(portfolioListProvider);
    final portfolio = portfolioList.firstWhere((e) => e.id == plannerId);

    return Scaffold(
      appBar: AppBar(),
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
                  Text(portfolio.name),
                  Text(portfolio.organization),
                ],
              ),
            ),
            const Divider(),
            Column(
              children: [
                ("활동 지역", portfolio.region),
                ("상담 가능 시간", portfolio.officeHours),
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
              child: Text(portfolio.introduction),
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
