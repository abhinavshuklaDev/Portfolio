// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';

import 'package:abhinav_portfolio/main.dart';

void main() {
  testWidgets('Portfolio app loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that the app loads with the name
    expect(find.text('Abhinav Shukla'), findsWidgets);
  });
}
