import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryBarcodeField extends StatelessWidget {
  const InventoryBarcodeField({
    required this.controller,
    required this.onScanPressed,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onScanPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createInventory.barcodeLabel,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
                  controller.text.isEmpty
                      ? AppStrings.createInventory.noBarcode
                      : controller.text,
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
