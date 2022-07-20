import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// Instance of [SettingsField] with a trailing [Switch].
class SwitchSettingsField extends StatefulWidget {
  /// Create a new [SwitchSettingsField] given a base [settingsField] and
  /// [prefKey].
  const SwitchSettingsField({
    super.key,
    required this.settingsField,
    required this.prefKey,
    this.initialValue = false,
    this.onChanged,
  });

  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Initial value to set.
  final bool initialValue;

  /// Callback for when selection changes.
  final void Function(bool value)? onChanged;

  @override
  State<SwitchSettingsField> createState() => _SwitchSettingsFieldState();
}

class _SwitchSettingsFieldState extends State<SwitchSettingsField> {
  late var _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newValue = sharedPrefs.getBool(widget.prefKey);
    if (newValue != _currentValue && newValue != null) {
      setState(() {
        _currentValue = newValue;
      });
    }
  }

  /// Store [newValue] and set the state.
  Future<void> _setValue(bool newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(widget.prefKey, newValue);
    setState(() {
      _currentValue = newValue;
    });

    widget.onChanged?.call(newValue);
  }

  @override
  void initState() {
    _updateValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _setValue(!_currentValue),
      child: Row(
        children: [
          Expanded(
            child: widget.settingsField,
          ),
          Switch(
            value: _currentValue,
            onChanged: _setValue,
          ),
        ],
      ),
    );
  }
}
