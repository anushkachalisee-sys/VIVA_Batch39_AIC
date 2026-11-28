// This is a basic Flutter widget test for VIVA.

import 'package:flutter_test/flutter_test.dart';
import 'package:viva/main.dart';

void main() {
  testWidgets('VIVA App starts up and shows login and mood discovery button', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const VivaApp());

    // Verify VIVA branding is present.
    expect(find.text('VIVA'), findsWidgets);
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Explore Mood Discovery 😌'), findsOneWidget);
  });
}
