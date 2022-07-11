import 'package:flutter/material.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// A single category to hold instances of [SettingsField].
class SettingsCategory extends StatelessWidget {
  /// Title of the category.
  final String title;

  /// List of type [SettingsField].
  final List<Widget> fields;

  const SettingsCategory({
    Key? key,
    required this.title,
    required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => fields[index],
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: fields.length,
        ),
      ],
    );
  }
}
