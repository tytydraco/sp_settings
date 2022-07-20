import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_settings/fields/settings_field.dart';

void main() {
  group('Settings field', () {
    testWidgets('All fields', (widgetTester) async {
      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: SettingsField(
              title: 'Example title',
              description: 'Example description',
              icon: Icons.abc,
            ),
          ),
        ),
      );

      expect(find.text('Example title'), findsOneWidget);
      expect(find.text('Example description'), findsOneWidget);
      expect(find.byIcon(Icons.abc), findsOneWidget);
    });

    testWidgets('Without description', (widgetTester) async {
      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: SettingsField(
              title: 'Example title',
              icon: Icons.abc,
            ),
          ),
        ),
      );

      expect(find.text('Example title'), findsOneWidget);
      expect(find.byIcon(Icons.abc), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('Without icon', (widgetTester) async {
      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: SettingsField(
              title: 'Example title',
              description: 'Example description',
            ),
          ),
        ),
      );

      expect(find.text('Example title'), findsOneWidget);
      expect(find.text('Example description'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('Without icon or description', (widgetTester) async {
      await widgetTester.pumpWidget(
        const Material(
          child: MaterialApp(
            home: SettingsField(
              title: 'Example title',
            ),
          ),
        ),
      );

      expect(find.text('Example title'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
