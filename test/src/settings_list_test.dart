import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_settings/src/settings_list.dart';

void main() {
  testWidgets('Settings list field', (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: SettingsList([
          Text('example field'),
        ]),
      ),
    );

    expect(find.text('example field'), findsOneWidget);
  });
}
