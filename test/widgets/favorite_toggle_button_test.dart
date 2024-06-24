import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Count of FavoriteToggleButton", () {
    const widget = MaterialApp(
      home: FavoriteToggleButton(
        initialFavorite: false,
        initialCount: 0,
      ),
    );

    testWidgets(
      "should be incremented and decremented when favorite is toggled",
      (tester) async {
        await tester.pumpWidget(widget);

        expect(find.text("0"), findsOneWidget);

        await tester.tap(find.byType(IconButton));
        await tester.pump();
        expect(find.text("1"), findsOneWidget);

        await tester.tap(find.byType(IconButton));
        await tester.pump();
        expect(find.text("0"), findsOneWidget);
      },
    );
  });
}
