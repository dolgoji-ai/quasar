import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quasar/main.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(CupertinoApp), findsOneWidget);

    await tester.pump();

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
  });
}
