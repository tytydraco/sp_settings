import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/checkbox_settings_field.dart';
import 'package:sp_settings/fields/settings_field.dart';

const testSettingsField = SettingsField(
  title: 'Example title',
  description: 'Example description',
  icon: Icons.abc,
);

void main() {
  group('Checkbox settings field', () {
    testWidgets('Field', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              prefKey: 'example',
            ),
          ),
        ),
      );

      expect(find.text(testSettingsField.title), findsOneWidget);
      expect(find.text(testSettingsField.description!), findsOneWidget);
      expect(find.byIcon(testSettingsField.icon!), findsOneWidget);
    });

    testWidgets('Initial value', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              prefKey: 'example',
              initialValue: true,
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Checkbox && widget.value == true,
        ),
        findsOneWidget,
      );
    });

    testWidgets('On changed callback', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      final completer = Completer<bool>();

      await widgetTester.pumpWidget(
        Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              prefKey: 'example',
              onChanged: completer.complete,
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(Checkbox));

      expect(completer.isCompleted, isTrue);
      expect(await completer.future, isTrue);
    });

    testWidgets('Checkbox state changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              prefKey: 'example',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(Checkbox));
      await widgetTester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Checkbox && widget.value == true,
        ),
        findsOneWidget,
      );
    });

    testWidgets('SharedPreferences changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              prefKey: 'example',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(Checkbox));

      expect(
        (await SharedPreferences.getInstance()).getBool('example'),
        isTrue,
      );
    });

    testWidgets('SharedPreferences changed with tristate',
        (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': false});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: CheckboxSettingsField(
              testSettingsField,
              tristate: true,
              prefKey: 'example',
            ),
          ),
        ),
      );

      expect(
        (await SharedPreferences.getInstance()).getBool('example'),
        isFalse,
      );

      await widgetTester.tap(find.byType(Checkbox));
      await widgetTester.pumpAndSettle();

      expect(
        (await SharedPreferences.getInstance()).getBool('example'),
        isTrue,
      );

      await widgetTester.tap(find.byType(Checkbox));
      await widgetTester.pumpAndSettle();

      expect(
        (await SharedPreferences.getInstance()).getBool('example'),
        isNull,
      );
    });
  });
}
