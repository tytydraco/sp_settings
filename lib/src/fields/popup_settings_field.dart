import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/src/fields/settings_field.dart';

/// Instance of [SettingsField] with an embedded [PopupMenuButton].
class PopupSettingsField extends StatefulWidget {
  /// Create a new [PopupSettingsField] given a base [settingsField] and
  /// [prefKey].
  const PopupSettingsField(
    this.settingsField, {
    super.key,
    required this.prefKey,
    this.enabled = true,
    this.initialValue,
    required this.items,
    this.onChanged,
  });

  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Allow this field's value to be mutated.
  final bool enabled;

  /// Initial value to set.
  final String? initialValue;

  /// Item map of display names to values.
  final Map<String, String> items;

  /// Callback for when selection changes.
  final void Function(String value)? onChanged;

  @override
  State<PopupSettingsField> createState() => _PopupSettingsFieldState();
}

class _PopupSettingsFieldState extends State<PopupSettingsField> {
  final _popupMenuState = GlobalKey<PopupMenuButtonState<String>>();
  var _hasValue = false;
  late var _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newValue =
        sharedPrefs.getString(widget.prefKey) ?? widget.initialValue;
    if (newValue != _currentValue || !_hasValue) {
      setState(() {
        _currentValue = newValue;
        _hasValue = true;
      });
    }
  }

  /// Store [_currentValue] and set the state.
  Future<void> _setValue(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(widget.prefKey, newValue);
    setState(() {
      _currentValue = newValue;
    });
    widget.onChanged?.call(newValue);
  }

  /// Custom [PopupMenuItem] for a given [key].
  PopupMenuItem<String> _popupMenuItem(String key) {
    final selected = _currentValue == widget.items[key];
    return PopupMenuItem(
      value: widget.items[key],
      child: Text(
        key,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  /// Convert the menu items into a list of type [PopupMenuItem].
  List<PopupMenuItem<String>> _menuItems() =>
      widget.items.keys.map(_popupMenuItem).toList();

  @override
  void initState() {
    _updateValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled && _hasValue
          ? () => _popupMenuState.currentState?.showButtonMenu()
          : null,
      child: Row(
        children: [
          Expanded(child: widget.settingsField),
          if (_hasValue)
            PopupMenuButton(
              key: _popupMenuState,
              itemBuilder: (context) => _menuItems(),
              onSelected: _setValue,
              enabled: widget.enabled,
            ),
        ],
      ),
    );
  }
}
