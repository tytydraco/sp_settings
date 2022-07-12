import 'package:flutter/material.dart';

/// A vertical, separated list of [SettingsField].
class SettingsList extends StatelessWidget {
  /// List of type [SettingsField].
  final List<Widget> fields;

  const SettingsList({
    Key? key,
    required this.fields,
  }) : super(key: key);

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
