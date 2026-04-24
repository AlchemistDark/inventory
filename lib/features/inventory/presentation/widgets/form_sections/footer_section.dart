import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    required this.descriptionController,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  final TextEditingController descriptionController;
  final DateTime selectedDate;
  final VoidCallback onSelectDate;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        InventoryTextField(
          controller: descriptionController,
          maxLines: 3,
          labelText: l10n.invForm_descriptionFieldLabel,
          validator: (value) {
            if (value != null && value.length > 500) {
              return l10n.invForm_maxLength500Error;
            }
            
            return null;
          },
        ),
        const SizedBox(height: 16),
        InventoryActionField(
          label: l10n.invForm_dateAddedLabel,
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
                child: Text(l10n.invForm_saveButton),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: onCancel,
                child: Text(l10n.invForm_cancelButton),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
