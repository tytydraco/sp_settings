import 'package:flutter/material.dart';

/// Base settings field with just the required fields.
class SettingsField extends StatefulWidget {
  /// Icon data to use.
  final IconData? icon;

  /// Display label.
  final String title;

  /// Single-line description.
  final String? description;

  const SettingsField({
    Key? key,
    this.icon,
    required this.title,
    this.description,
  }) : super(key: key);

  @override
  State<SettingsField> createState() => _SettingsFieldState();
}

class _SettingsFieldState extends State<SettingsField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 32px icon, centered
          if (widget.icon != null)
            Icon(
              widget.icon!,
              size: 32,
            )
          else
            Container(),
          // Title and description stacked vertically
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.description != null)
                    Text(
                      widget.description!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
