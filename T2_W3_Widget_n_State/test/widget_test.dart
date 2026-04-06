// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:t2_w3_widget_n_state/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Basic smoke checks for the UI.
    expect(find.text('My First App'), findsOneWidget);
    expect(find.byType(FlutterLogo), findsOneWidget);
    expect(find.text('What image is that'), findsOneWidget);

    // Verify that our counter starts at 4.
    expect(find.text('Counter here: 4'), findsOneWidget);
    expect(find.text('Counter here: 5'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    final plusFinder = find.byIcon(Icons.add);
    await tester.scrollUntilVisible(plusFinder, 200);
    await tester.tap(plusFinder);
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Counter here: 4'), findsNothing);
    expect(find.text('Counter here: 5'), findsOneWidget);
  });
}
