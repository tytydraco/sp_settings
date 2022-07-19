import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_settings/fields/button_settings_field.dart';
import 'package:sp_settings/fields/settings_field.dart';

const testSettingsField = SettingsField(
  title: 'Example title',
  description: 'Example description',
  icon: Icons.abc,
);

void main() {
  group('Switch settings field', () {
    testWidgets('Field', (widgetTester) async {
      await widgetTester.pumpWidget(const Material(
        child: MaterialApp(
          home: ButtonSettingsField(
            settingsField: testSettingsField,
          ),
        ),
      ));

      expect(find.text(testSettingsField.title), findsOneWidget);
      expect(find.text(testSettingsField.description!), findsOneWidget);
      expect(find.byIcon(testSettingsField.icon!), findsOneWidget);
    });

    testWidgets('On tap callback', (widgetTester) async {
      final completer = Completer();

      await widgetTester.pumpWidget(Material(
        child: MaterialApp(
          home: ButtonSettingsField(
            settingsField: testSettingsField,
            onTap: completer.complete,
          ),
        ),
      ));

      await widgetTester.tap(find.byType(InkWell));

      expect(completer.isCompleted, isTrue);
      expect(await completer.future, isNull);
    });

    testWidgets('On long press callback', (widgetTester) async {
      final completer = Completer();

      await widgetTester.pumpWidget(Material(
        child: MaterialApp(
          home: ButtonSettingsField(
            settingsField: testSettingsField,
            onLongPress: completer.complete,
          ),
        ),
      ));

      await widgetTester.longPress(find.byType(InkWell));

      expect(completer.isCompleted, isTrue);
      expect(await completer.future, isNull);
    });
  });
}
