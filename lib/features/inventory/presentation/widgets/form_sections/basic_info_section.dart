import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({
    required this.nameController,
    required this.inventoryNumberController,
    required this.quantityController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController inventoryNumberController;
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        InventoryTextField(
          controller: nameController,
          labelText: l10n.invForm_nameFieldLabel,
          maxLength: 50,
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
        InventoryTextField(
          controller: inventoryNumberController,
          labelText: l10n.invForm_inventoryNumberFieldLabel,
          maxLength: 50,
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(height: 16),
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
