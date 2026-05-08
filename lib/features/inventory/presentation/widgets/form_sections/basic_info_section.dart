import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A section of the inventory form for entering basic item details.
///
/// Includes fields for the item's name, inventory number, and quantity,
/// each with their respective validation rules.
class BasicInfoSection extends StatelessWidget {
  /// Creates a [BasicInfoSection].
  const BasicInfoSection({
    required this.nameController,
    required this.inventoryNumberController,
    required this.quantityController,
    super.key,
  });

  /// Controller for the item name input.
  final TextEditingController nameController;

  /// Controller for the unique inventory number input.
  final TextEditingController inventoryNumberController;

  /// Controller for the quantity input.
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Name field with mandatory validation and minimum length check.
        InventoryTextField(
          controller: nameController,
          labelText: l10n.invForm_nameFieldLabel,
          maxLength: 50,
          showCounter: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.invForm_nameRequiredError;
            }
            if (value.length < 3) {
              return l10n.invForm_minLength3Error;
            }

            return null;
          },
        ),
        const SizedBox(height: 16),
        // Inventory number field (mandatory).
        InventoryTextField(
          controller: inventoryNumberController,
          labelText: l10n.invForm_inventoryNumberFieldLabel,
          maxLength: 50,
          showCounter: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.invForm_inventoryNumberRequiredError;
            }

            return null;
          },
        ),
        const SizedBox(height: 16),
        // Quantity field with numeric keyboard and range validation (1-999).
        InventoryTextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          labelText: l10n.invForm_quantityFieldLabel,
          maxLength: 3,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return l10n.invForm_quantityRequiredError;
            }
            final qty = int.tryParse(value);
            if (qty == null || qty < 1 || qty > 999) {
              return l10n.invForm_quantityRangeError;
            }

            return null;
          },
        ),
      ],
    );
  }
}
