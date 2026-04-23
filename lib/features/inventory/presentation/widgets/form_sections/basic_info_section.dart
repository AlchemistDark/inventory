import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class BasicInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController inventoryNumberController;
  final TextEditingController quantityController;

  const BasicInfoSection({
    required this.nameController,
    required this.inventoryNumberController,
    required this.quantityController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InventoryTextField(
          controller: nameController,
          labelText: AppStrings.createInventory.nameFieldLabel,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppStrings.createInventory.nameRequiredError;
            }
            if (value.length < 3) {
              return AppStrings.createInventory.minLength3Error;
            }
            if (value.length > 50) {
              return AppStrings.createInventory.maxLength50Error;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        InventoryTextField(
          controller: inventoryNumberController,
          labelText: AppStrings.createInventory.inventoryNumberFieldLabel,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.createInventory.quantityRequiredError;
            }
            final qty = int.tryParse(value);
            if (qty == null || qty < 1 || qty > 999) {
              return AppStrings.createInventory.quantityRangeError;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        InventoryTextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          labelText: AppStrings.createInventory.quantityFieldLabel,
          validator: (value) {
            if (value == null || value.isEmpty)
              return AppStrings.createInventory.quantityRequiredError;
            final qty = int.tryParse(value);
            if (qty == null || qty < 1 || qty > 999)
              return AppStrings.createInventory.quantityRangeError;
            return null;
          },
        ),
      ],
    );
  }
}
