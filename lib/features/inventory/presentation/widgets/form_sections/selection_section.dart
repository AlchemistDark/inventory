import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A section of the inventory form for selecting related metadata.
///
/// Provides selection fields for the responsible employee, category, and room.
/// It resolves the current selection names from the provided lists for display.
class SelectionSection extends StatelessWidget {
  /// Creates a [SelectionSection].
  const SelectionSection({
    required this.employees,
    required this.onEmployeeSelected,
    required this.onCategorySelected,
    required this.onRoomSelected,
    this.selectedEmployeeId,
    this.selectedCategoryId,
    this.selectedRoomId,
    super.key,
  });

  /// List of employees for the selection field.
  final List<EmployeeModel> employees;

  /// The ID of the currently selected employee.
  final int? selectedEmployeeId;

  /// The ID of the currently selected category.
  final int? selectedCategoryId;

  /// The ID of the currently selected room.
  final int? selectedRoomId;

  /// Callback triggered when an employee is selected.
  final void Function(int?) onEmployeeSelected;

  /// Callback triggered when a category is selected.
  final void Function(int?) onCategorySelected;

  /// Callback triggered when a room is selected.
  final void Function(int?) onRoomSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Resolve display names for current selections.
    final empName =
        employees.where((e) => e.id == selectedEmployeeId).firstOrNull?.name ??
            l10n.invForm_notSelected;

    return Column(
      children: [
        // Selection field for the responsible person.
        InventorySelectionField<EmployeeModel>(
          label: l10n.invForm_responsibleLabel,
          selectedName: empName,
          icon: Icons.person,
          items: employees,
          selectedId: selectedEmployeeId,
          itemName: (e) => e.name,
          itemId: (e) => e.id,
          onSelected: onEmployeeSelected,
        ),
        const SizedBox(height: 16),
        // Selection field for the item category.
        const SizedBox(height: 16),
        // Selection field for the item's location (room).
      ],
    );
  }
}
