import 'package:flutter_test/flutter_test.dart';

import 'package:chayxana_app/main.dart';

void main() {
  testWidgets('App boots to splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ChayxanaApp());
    expect(find.text('ЧАЙХАНА'), findsOneWidget);
  });
}
