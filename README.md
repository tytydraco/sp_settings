# sp_settings

A Flutter settings screen package with Shared Preferences integration.

## Features

* Only external dependency is `shared_preferences`
* Consistent design pattern
* Stores value changes directly to shared preferences

## Getting started

Add `sp_settings` to your project: `flutter pub add sp_settings`

## Usage

The following example is a basic hierarchy for a settings screen.

```dart
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/fields/settings_list.dart';
import 'package:sp_settings/fields/switch_settings_field_test.dart';

SettingsList(
    fields: [
        SwitchSettingsField(
            settingsField: SettingsField(
                title: 'Example',
                description: 'This is an example.',
                icon: Icons.add,
            ),
            prefKey: 'example',
        ),
    ]
);
```

A settings list can be surrounded by a `SettingsCategory`, allowing clear separations to be made:

```dart
import 'package:sp_settings/settings_category.dart';

SettingsCategory(
  title: 'Category title',
  settingsList: <SettingsList>,
);
```
