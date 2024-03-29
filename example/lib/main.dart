import 'package:flutter/material.dart';
import 'package:sp_settings/sp_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Form',
      theme: ThemeData(primarySwatch: Colors.blue),
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
      body: ListView(
        children: [
          const SettingsCategory(
              title: 'General',
              settingsList: SettingsList([
                SwitchSettingsField(
                  SettingsField(
                    title: 'Example',
                    description: 'This is an example.',
                    icon: Icons.add,
                  ),
                  prefKey: 'example1',
                ),
              ])),
          SettingsCategory(
            title: 'Other',
            settingsList: SettingsList([
              const SwitchSettingsField(
                SettingsField(
                  title: 'Long text switch',
                  description:
                      'This is an example. The description is a lot longer. It is very very long. It reaches three lines.',
                  icon: Icons.folder,
                ),
                prefKey: 'example2',
              ),
              ButtonSettingsField(
                const SettingsField(
                  title: 'Clickable',
                  description: 'Here is a button setting that can be clicked.',
                  icon: Icons.person_off,
                ),
                onTap: () {},
              ),
              const PopupSettingsField(
                SettingsField(
                  title: 'Pop-up',
                  description: 'Here is a pop-up menu! Select one of these.',
                  icon: Icons.drive_eta,
                ),
                prefKey: 'popup',
                items: {
                  'None': 'null',
                  'Apple': 'a',
                  'Banana': 'b',
                  'Carrot': 'c',
                  'Lemon': 'l',
                  'Strawberry': 's',
                },
                initialValue: 'null',
              ),
              const CheckboxSettingsField(
                SettingsField(
                  title: 'Checkbox',
                  description: 'This has two options to choose from.',
                  icon: Icons.check_box_outline_blank,
                ),
                prefKey: 'checkbox',
              ),
            ]),
          )
        ],
      ),
    );
  }
}
