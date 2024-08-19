import 'package:dears/utils/icons.dart';
import 'package:dears/widgets/favorite_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("FavoriteCountToggleButton", () {
    const widget = MaterialApp(
      home: FavoriteToggleButton(initialFavorite: false),
    );

    testWidgets(
      "should be incremented and decremented when favorite is toggled",
      (tester) async {
        await tester.pumpWidget(widget);

        expect(find.byIcon(DearsIcons.favorite_outline), findsOneWidget);

        await tester.tap(find.byType(IconButton));
        await tester.pump();
        expect(find.byIcon(DearsIcons.favorite), findsOneWidget);

        await tester.tap(find.byType(IconButton));
        await tester.pump();
        expect(find.byIcon(DearsIcons.favorite_outline), findsOneWidget);
      },
    );
  });
}
