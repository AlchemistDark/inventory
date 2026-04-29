import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// The final section of the inventory form containing additional info and actions.
///
/// Includes the description field, date selection, and the main Save/Cancel buttons.
class FooterSection extends StatelessWidget {
  /// Creates a [FooterSection].
  const FooterSection({
    required this.descriptionController,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  /// Controller for the optional description or notes field.
  final TextEditingController descriptionController;

  /// The currently selected date for the inventory.
  final DateTime selectedDate;

  /// Callback to open the date picker.
  final VoidCallback onSelectDate;

  /// Callback to submit the entire form.
  final VoidCallback onSubmit;

  /// Callback to cancel form entry and navigate back.
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Multi-line description field with length validation.
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
        // Interactive field for date selection.
        InventoryActionField(
          label: l10n.invForm_dateAddedLabel,
          valueText: DateFormat.yMd(Localizations.localeOf(context).toString())
              .format(selectedDate),
          icon: Icons.calendar_today,
          onTap: onSelectDate,
        ),
        const SizedBox(height: 24),
        // Primary action buttons (Save and Cancel).
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
