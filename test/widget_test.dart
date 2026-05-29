import 'package:flutter_test/flutter_test.dart';

import 'package:postestapp/main.dart';

void main() {
  testWidgets('App renders home screen with greeting', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('What will you like to do today?'), findsOneWidget);
  });
}
