import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// Instance of [SettingsField] with a trailing [DropdownButton].
class DropdownSettingsField<T> extends StatefulWidget {
  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Initial value to set.
  final T? initialValue;

  /// Item map of display names to [T].
  final Map<String, T> items;

  /// Callback for when selection changes.
  final void Function(T value)? onChanged;

  const DropdownSettingsField({
    Key? key,
    required this.settingsField,
    required this.prefKey,
    this.initialValue,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownSettingsField> createState() => _DropdownSettingsFieldState();
}

class _DropdownSettingsFieldState<T> extends State<DropdownSettingsField> {
  late var _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    T? newValue;
    switch (T) {
      case String:
        newValue = sharedPrefs.getString(widget.prefKey) as T;
        break;
      case int:
        newValue = sharedPrefs.getInt(widget.prefKey) as T;
        break;
      case double:
        newValue = sharedPrefs.getDouble(widget.prefKey) as T;
        break;
    }

    if (newValue != _currentValue && newValue != null) {
      setState(() {
        _currentValue = newValue;
      });
    }
  }

  /// Store [_currentValue] and set the state.
  Future<void> _setValue(T newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    switch (T) {
      case String:
        sharedPrefs.setString(widget.prefKey, newValue as String);
        break;
      case int:
        sharedPrefs.setInt(widget.prefKey, newValue as int);
        break;
      case double:
        sharedPrefs.setDouble(widget.prefKey, newValue as double);
        break;
    }

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
    return Row(
      children: [
        Expanded(
          child: widget.settingsField,
        ),
        DropdownButton<T>(
          value: _currentValue,
          items: widget.items.keys
              .map((title) => DropdownMenuItem<T>(
                    value: widget.items[title],
                    child: Text(title),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              _setValue(value);
            }
          }
        ),
      ],
    );
  }
}
