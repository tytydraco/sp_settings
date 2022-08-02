import 'package:flutter/material.dart';

/// Base settings field with just the required fields.
class SettingsField extends StatefulWidget {
  /// Create a new [SettingsField] given a [title].
  const SettingsField({
    super.key,
    required this.title,
    this.icon,
    this.description,
  });

  /// Display label.
  final String title;

  /// Icon data to use.
  final IconData? icon;

  /// Single-line description.
  final String? description;

  @override
  State<SettingsField> createState() => _SettingsFieldState();
}

class _SettingsFieldState extends State<SettingsField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          // 32px icon, centered.
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                widget.icon,
                size: 32,
              ),
            )
          else
            Container(),
          // Title and description stacked vertically.
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                if (widget.description != null)
                  Text(
                    widget.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 12),
                  )
                else
                  Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
