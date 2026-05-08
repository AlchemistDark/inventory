import 'package:flutter/material.dart';

/// A styled text input field for inventory-related forms.
///
/// Wraps [TextFormField] with a consistent border, label, and validation logic
/// according to the application's design system.
class InventoryTextField extends StatelessWidget {
  /// Creates an [InventoryTextField].
  const InventoryTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.showCounter = false,
    super.key,
  });

  /// Controller for the text being edited.
  final TextEditingController controller;

  /// Label text shown as a hint or floating label.
  final String labelText;

  /// Validation logic for the field input.
  final String? Function(String?)? validator;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// Maximum number of lines (defaults to 1).
  final int maxLines;

  /// Maximum character length allowed.
  final int? maxLength;

  /// Whether to show the character counter (requires [maxLength]).
  final bool showCounter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // Show counter only if explicitly requested or if it's a multi-line field.
        counterText: showCounter ? null : '',
      ),
      validator: validator,
    );
  }
}
