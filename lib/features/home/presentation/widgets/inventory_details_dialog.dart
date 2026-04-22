import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

class InventoryDetailsDialog extends StatelessWidget {
  final InventoryEntity inventory;
  final VoidCallback onEdit;

  const InventoryDetailsDialog({
    super.key,
    required this.inventory,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.home.itemDetailsTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(AppStrings.home.nameLabel, inventory.name),
            _buildDetailRow(
              AppStrings.home.barcodeLabel,
              inventory.barcode ?? AppStrings.home.notSpecified,
            ),
            _buildDetailRow(
              AppStrings.home.inventoryNumberLabel,
              inventory.inventoryNumber ?? AppStrings.home.notSpecified,
            ),
            _buildDetailRow(
              AppStrings.home.quantityLabel,
              '${inventory.quantity}',
            ),
            if (inventory.description != null)
              _buildDetailRow(
                AppStrings.home.descriptionLabel,
                inventory.description!,
              ),
            _buildDetailRow(
              AppStrings.home.registrationDateLabel,
              inventory.dateAdded.toString().split(' ')[0],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.home.closeDialogButton),
        ),
        ElevatedButton(
          onPressed: onEdit,
          child: Text(AppStrings.home.editButton),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
