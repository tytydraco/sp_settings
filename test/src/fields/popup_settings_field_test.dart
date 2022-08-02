import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/sp_settings.dart';

const testSettingsField = SettingsField(
  title: 'Example title',
  description: 'Example description',
  icon: Icons.abc,
);

void main() {
  group('Popup settings field', () {
    testWidgets('Field', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: {},
            ),
          ),
        ),
      );

      expect(find.text(testSettingsField.title), findsOneWidget);
      expect(find.text(testSettingsField.description!), findsOneWidget);
      expect(find.byIcon(testSettingsField.icon!), findsOneWidget);
    });

    testWidgets('Initial value', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: {
                'a': 'a',
                'b': 'b',
                'c': 'c',
                'd': 'd',
              },
              initialValue: 'c',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.style?.fontWeight == FontWeight.bold &&
              widget.data == 'c',
        ),
        findsOneWidget,
      );
    });

    testWidgets('On changed callback', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      final completer = Completer<String>();

      await widgetTester.pumpWidget(
        Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: const {
                'a': 'a',
                'b': 'b',
                'c': 'c',
                'd': 'd',
              },
              initialValue: 'c',
              onChanged: completer.complete,
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('d'));
      await widgetTester.pumpAndSettle();

      expect(completer.isCompleted, isTrue);
      expect(await completer.future, 'd');
    });

    testWidgets('Popup state changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: {
                'a': 'a',
                'b': 'b',
                'c': 'c',
                'd': 'd',
              },
              initialValue: 'c',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('d'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.style?.fontWeight == FontWeight.bold &&
              widget.data == 'd',
        ),
        findsOneWidget,
      );
    });

    testWidgets('SharedPreferences changed', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: {
                'a': 'a',
                'b': 'b',
                'c': 'c',
                'd': 'd',
              },
              initialValue: 'c',
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('d'));
      await widgetTester.pumpAndSettle();

      expect(
        (await SharedPreferences.getInstance()).getString('example'),
        'd',
      );
    });

    testWidgets('Open when disabled', (widgetTester) async {
      SharedPreferences.setMockInitialValues({'example': 'c'});

      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: PopupSettingsField(
              testSettingsField,
              prefKey: 'example',
              items: {
                'a': 'a',
                'b': 'b',
                'c': 'c',
                'd': 'd',
              },
              initialValue: 'c',
              enabled: false,
            ),
          ),
        ),
      );

      await widgetTester.tap(find.byType(PopupMenuButton<String>));
      await widgetTester.pumpAndSettle();

      expect(find.text('d'), findsNothing);
    });
  });
}
