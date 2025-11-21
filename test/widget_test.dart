import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quasar/main.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
