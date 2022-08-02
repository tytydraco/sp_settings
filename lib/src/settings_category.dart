import 'package:flutter/material.dart';
import 'package:sp_settings/src/fields/settings_field.dart';
import 'package:sp_settings/src/settings_list.dart';

/// A single category to hold a [SettingsList].
class SettingsCategory extends StatelessWidget {
  /// Create a new [SettingsCategory] given a [title] and a [settingsList].
  const SettingsCategory({
    super.key,
    required this.title,
    required this.settingsList,
  });

  /// Title of the category.
  final String title;

  /// List of type [SettingsField].
  final SettingsList settingsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        settingsList,
      ],
    );
  }
}
