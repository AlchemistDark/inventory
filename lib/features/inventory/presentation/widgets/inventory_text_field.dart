import 'package:flutter/material.dart';

class InventoryTextField extends StatelessWidget {
  const InventoryTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;

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
        counterText: '', // Скрываем счетчик символов снизу, если не нужен
      ),
      validator: validator,
    );
  }
}
