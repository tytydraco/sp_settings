import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/src/fields/settings_field.dart';

/// Instance of [SettingsField] with a trailing [Checkbox].
class CheckboxSettingsField extends StatefulWidget {
  /// Create a new [CheckboxSettingsField] given a base [settingsField] and
  /// [prefKey].
  const CheckboxSettingsField(
    this.settingsField, {
    super.key,
    required this.prefKey,
    this.enabled = true,
    this.initialValue = false,
    this.tristate = false,
    this.onChanged,
  });

  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Allow this field's value to be mutated.
  final bool enabled;

  /// Initial value to set.
  final bool? initialValue;

  /// Support three states as opposed to only two.
  final bool tristate;

  /// Callback for when selection changes.
  final void Function(bool? value)? onChanged;

  @override
  State<CheckboxSettingsField> createState() => _CheckboxSettingsFieldState();
}

class _CheckboxSettingsFieldState extends State<CheckboxSettingsField> {
  late var _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newValue = sharedPrefs.getBool(widget.prefKey);
    if (newValue != _currentValue) {
      setState(() {
        _currentValue = newValue;
      });
    }
  }

  /// Store [newValue] and set the state.
  Future<void> _setValue(bool? newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (newValue == null) {
      await sharedPrefs.remove(widget.prefKey);
    } else {
      await sharedPrefs.setBool(widget.prefKey, newValue);
    }
    setState(() {
      _currentValue = newValue;
    });

    widget.onChanged?.call(newValue);
  }

  /// Return the next value that would be given for a tristate [Checkbox] given
  /// a [current] value.
  bool? _getNextTristate(bool? current) {
    switch (current) {
      case null:
        return false;
      case false:
        return true;
      case true:
        return null;
      default:
        return null;
    }
  }

  @override
  void initState() {
    _updateValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled
          ? () => _setValue(_getNextTristate(_currentValue))
          : null,
      child: Row(
        children: [
          Expanded(
            child: widget.settingsField,
          ),
          Checkbox(
            value: _currentValue,
            onChanged: widget.enabled ? _setValue : null,
            tristate: widget.tristate,
          ),
        ],
      ),
    );
  }
}
