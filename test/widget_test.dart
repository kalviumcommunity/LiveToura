// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:livetoura/main.dart';

import 'package:livetoura/screens/welcome_screen.dart';

void main() {
  testWidgets('Welcome screen toggle smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LiveTouraBasicsApp());

    // Verify that our title and initial button text are present.
    expect(find.text('Tournament Tracker'), findsOneWidget);
    expect(find.text('Toggle On'), findsOneWidget);
    expect(find.text('Toggle Off'), findsNothing);

    // Tap the button and trigger a frame.
    await tester.tap(find.text('Toggle On'));
    await tester.pump();

    // Verify that the button text changed.
    expect(find.text('Toggle On'), findsNothing);
    expect(find.text('Toggle Off'), findsOneWidget);
  });
}
