import 'package:flutter/material.dart';
import 'package:sp_settings/settings_category.dart';

/// Top-level settings form widget.
class SettingsForm extends StatelessWidget {
  /// List of type [SettingsCategory], which each hold their own fields.
  final List<SettingsCategory> categories;

  const SettingsForm({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: categories,
    );
  }
}
