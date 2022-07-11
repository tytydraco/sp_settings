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
import 'package:sp_settings/settings_form.dart';
import 'package:sp_settings/settings_category.dart';
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/fields/switch_settings_field.dart';

SettingsForm(
    categories: [
        SettingsCategory(
            title: 'General',
            fields: [
                SwitchSettingsField(
                    settingsField: SettingsField(
                        title: 'Example',
                        description: 'This is an example.',
                        icon: Icons.add,
                    ),
                    prefKey: 'example1',
                ),
            ],
        ),
    ],
);
```
