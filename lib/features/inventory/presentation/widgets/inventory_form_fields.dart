import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const InventoryTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}

class InventoryActionField extends StatelessWidget {
  final String label;
  final String valueText;
  final IconData icon;
  final VoidCallback onTap;

  const InventoryActionField({
    super.key,
    required this.label,
    required this.valueText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(valueText),
                Icon(icon),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InventoryBarcodeField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onScanPressed;

  const InventoryBarcodeField({
    super.key,
    required this.controller,
    required this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.createInventory.barcodeLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.text.isEmpty ? AppStrings.createInventory.noBarcode : controller.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onScanPressed,
              icon: const Icon(Icons.qr_code_2),
              tooltip: AppStrings.createInventory.scanOrInputTooltip,
            ),
          ],
        ),
      ],
    );
  }
}
