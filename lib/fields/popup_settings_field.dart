import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_settings/fields/settings_field.dart';

/// Instance of [SettingsField] with an embedded [PopupMenuButton].
class PopupSettingsField extends StatefulWidget {
  /// Settings field child.
  final SettingsField settingsField;

  /// Preference key to store value in.
  final String prefKey;

  /// Initial value to set.
  final String? initialValue;

  /// Item map of display names to values.
  final Map<String, String> items;

  /// Callback for when selection changes.
  final void Function(String value)? onChanged;

  const PopupSettingsField({
    Key? key,
    required this.settingsField,
    required this.prefKey,
    this.initialValue,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PopupSettingsField> createState() => _PopupSettingsFieldState();
}

class _PopupSettingsFieldState extends State<PopupSettingsField> {
  final _popupMenuState = GlobalKey<PopupMenuButtonState>();
  late String? _currentValue = widget.initialValue;

  /// Retrieve [_currentValue] and set the state.
  Future<void> _updateValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newValue = sharedPrefs.getString(widget.prefKey);
    if (newValue != _currentValue && newValue != null) {
      setState(() {
        _currentValue = newValue;
      });
    }
  }

  /// Store [_currentValue] and set the state.
  Future<void> _setValue(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(widget.prefKey, newValue);
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

  /// Convert the [items] to a list of type [PopupMenuItem].
  List<PopupMenuItem<String>> _menuItems() =>
      widget.items.keys.map((key) => _popupMenuItem(key)).toList();

  @override
  void initState() {
    _updateValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _popupMenuState.currentState?.showButtonMenu(),
      child: Row(
        children: [
          Expanded(
            child: widget.settingsField,
          ),
          PopupMenuButton(
            key: _popupMenuState,
            itemBuilder: (context) => _menuItems(),
            onSelected: _setValue,
          ),
        ],
      ),
    );
  }
}
