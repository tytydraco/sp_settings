import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/src/fields/settings_field.dart';

/// Instance of [SettingsField] with a trailing [Switch].
class SwitchSettingsField extends StatefulWidget {
  /// Create a new [SwitchSettingsField] given a base [settingsField] and
  /// [prefKey].
  const SwitchSettingsField(
    this.settingsField, {
    super.key,
    required this.prefKey,
    this.enabled = true,
    this.initialValue = false,
    this.onChanged,
  });

  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Allow this field's value to be mutated.
  final bool enabled;

  /// Initial value to set.
  final bool initialValue;

  /// Callback for when selection changes.
  final void Function(bool value)? onChanged;

  @override
  State<SwitchSettingsField> createState() => _SwitchSettingsFieldState();
}

class _SwitchSettingsFieldState extends State<SwitchSettingsField> {
  var _hasValue = false;
  late var _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newValue = sharedPrefs.getBool(widget.prefKey) ?? widget.initialValue;
    if (newValue != _currentValue || !_hasValue) {
      setState(() {
        _currentValue = newValue;
        _hasValue = true;
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
      onTap:
          widget.enabled && _hasValue ? () => _setValue(!_currentValue) : null,
      child: Row(
        children: [
          Expanded(child: widget.settingsField),
          if (_hasValue)
            Switch(
              value: _currentValue,
              onChanged: widget.enabled ? _setValue : null,
            ),
        ],
      ),
    );
  }
}
