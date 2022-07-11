import 'package:flutter/material.dart';
import 'package:sp_settings/settings_form.dart';
import 'package:sp_settings/settings_category.dart';
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/fields/switch_settings_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Form',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const MyHomePage(title: 'Settings Form Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SettingsForm(
        categories: [
          SettingsCategory(title: 'General', fields: [
            SwitchSettingsField(
              settingsField: SettingsField(
                title: 'Example',
                description: 'This is an example.',
                icon: Icons.add,
              ),
              prefKey: 'example1',
            ),
          ]),
          SettingsCategory(title: 'Other', fields: [
            SwitchSettingsField(
              settingsField: SettingsField(
                title: 'Example',
                description: 'This is an example.',
                icon: Icons.folder,
              ),
              prefKey: 'example2',
            ),
          ]),
        ],
      ),
    );
  }
}
