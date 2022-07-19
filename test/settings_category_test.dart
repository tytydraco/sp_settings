import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sp_settings/settings_category.dart';
import 'package:sp_settings/settings_list.dart';

void main() {
  testWidgets('Settings category', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SettingsCategory(
        title: 'Title',
        settingsList: SettingsList(fields: []),
      ),
    ));

    expect(find.text('Title'), findsOneWidget);
    expect(find.byType(SettingsList), findsOneWidget);
  });
}
