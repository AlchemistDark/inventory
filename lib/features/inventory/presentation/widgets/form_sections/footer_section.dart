import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class FooterSection extends StatelessWidget {
  final TextEditingController descriptionController;
  final DateTime selectedDate;
  final VoidCallback onSelectDate;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const FooterSection({
    required this.descriptionController,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InventoryTextField(
          controller: descriptionController,
          maxLines: 3,
          labelText: AppStrings.createInventory.descriptionFieldLabel,
          validator: (value) {
            if (value != null && value.length > 500) {
              return AppStrings.createInventory.maxLength500Error;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        InventoryActionField(
          label: AppStrings.createInventory.dateAddedLabel,
          valueText: DateFormat('dd.MM.yyyy').format(selectedDate),
          icon: Icons.calendar_today,
          onTap: onSelectDate,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(AppStrings.createInventory.saveButton),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: onCancel,
                child: Text(AppStrings.createInventory.cancelButton),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
