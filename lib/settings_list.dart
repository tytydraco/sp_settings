import 'package:flutter/material.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// A vertical, separated list of [SettingsField].
class SettingsList extends StatelessWidget {
  /// Create a new [SettingsList] given a list of [fields].
  const SettingsList(
    this.fields, {
    super.key,
  });

  /// List of type [SettingsField].
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => fields[index],
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: fields.length,
    );
  }
}
