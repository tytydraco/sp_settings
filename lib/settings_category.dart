import 'package:flutter/material.dart';
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/settings_list.dart';

/// A single category to hold a [SettingsList].
class SettingsCategory extends StatelessWidget {
  /// Title of the category.
  final String title;

  /// List of type [SettingsField].
  final SettingsList settingsList;

  const SettingsCategory({
    Key? key,
    required this.title,
    required this.settingsList,
  }) : super(key: key);

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
