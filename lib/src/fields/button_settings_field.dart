import 'package:flutter/material.dart';
import 'package:sp_settings/src/fields/settings_field.dart';

/// Instance of [SettingsField] embedded in an [InkWell]. The button will be
/// disabled if both callbacks are set to null.
class ButtonSettingsField extends StatefulWidget {
  /// Create a new [ButtonSettingsField] given a base [settingsField].
  const ButtonSettingsField(
    this.settingsField, {
    super.key,
    this.onTap,
    this.onLongPress,
  });

  /// Settings field child.
  final SettingsField settingsField;

  /// Callback for tap.
  final void Function()? onTap;

  /// Callback for long press.
  final void Function()? onLongPress;

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
