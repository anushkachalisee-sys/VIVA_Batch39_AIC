import 'package:flutter_test/flutter_test.dart';
import 'package:viva/main.dart';

void main() {
  testWidgets('Edit Profile screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VivaApp());

    // Verify that Edit Profile screen elements are present.
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Bio'), findsOneWidget);
    expect(find.text('Music Preferences'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);
  });
}
