import 'package:flutter_test/flutter_test.dart';

import 'package:postestapp/main.dart';

void main() {
  testWidgets('App renders home screen with greeting and heading',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final hour = DateTime.now().hour;
    final expectedGreeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    expect(find.text(expectedGreeting), findsOneWidget);
    expect(find.text('What will you like to do today?'), findsOneWidget);
  });
}
