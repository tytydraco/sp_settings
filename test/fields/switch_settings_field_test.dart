import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/fields/switch_settings_field.dart';

const testSettingsField = SettingsField(
  title: 'Example title',
  description: 'Example description',
  icon: Icons.abc,
);

void main() {
  group('Switch settings field', () {
    testWidgets('Field', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(const Material(
        child: MaterialApp(
          home: SwitchSettingsField(
            settingsField: testSettingsField,
            prefKey: 'example',
          ),
        ),
      ));

      expect(find.text(testSettingsField.title), findsOneWidget);
      expect(find.text(testSettingsField.description!), findsOneWidget);
      expect(find.byIcon(testSettingsField.icon!), findsOneWidget);
    });

    testWidgets('Initial value', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(const Material(
        child: MaterialApp(
          home: SwitchSettingsField(
            settingsField: testSettingsField,
            prefKey: 'example',
            initialValue: true,
          ),
        ),
      ));

      expect(
          find.byWidgetPredicate(
              (widget) => widget is Switch && widget.value == true),
          findsOneWidget);
    });

    testWidgets('On changed callback', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      final completer = Completer();

      await widgetTester.pumpWidget(Material(
        child: MaterialApp(
          home: SwitchSettingsField(
            prefKey: 'example',
            settingsField: testSettingsField,
            onChanged: (value) => completer.complete(value),
          ),
        ),
      ));

      await widgetTester.tap(find.byType(Switch));

      expect(completer.isCompleted, isTrue);
      expect(await completer.future, isTrue);
    });

    testWidgets('Switch state changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(const Material(
        child: MaterialApp(
          home: SwitchSettingsField(
            prefKey: 'example',
            settingsField: testSettingsField,
          ),
        ),
      ));

      await widgetTester.tap(find.byType(Switch));
      await widgetTester.pumpAndSettle();

      expect(
          find.byWidgetPredicate(
              (widget) => widget is Switch && widget.value == true),
          findsOneWidget);
    });

    testWidgets('SharedPreferences changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(const Material(
        child: MaterialApp(
          home: SwitchSettingsField(
            prefKey: 'example',
            settingsField: testSettingsField,
          ),
        ),
      ));

      await widgetTester.tap(find.byType(Switch));

      expect(
          (await SharedPreferences.getInstance()).getBool('example'), isTrue);
    });
  });
}
