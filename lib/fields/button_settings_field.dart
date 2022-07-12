import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// Instance of [SettingsField] embedded in an [InkWell].
class ButtonSettingsField extends StatefulWidget {
  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Callback for tap.
  final void Function()? onTap;

  /// Callback for long press.
  final void Function()? onLongPress;

  const ButtonSettingsField({
    Key? key,
    required this.settingsField,
    required this.prefKey,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<ButtonSettingsField> createState() => _ButtonSettingsFieldState();
}

class _ButtonSettingsFieldState extends State<ButtonSettingsField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: widget.settingsField,
    );
  }
}
