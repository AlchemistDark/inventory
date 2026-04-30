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
    required this.categories,
    required this.rooms,
    required this.onEmployeeSelected,
    required this.onCategoriesSelected,
    required this.onRoomSelected,
    this.selectedEmployeeId,
    this.selectedCategoryIds = const [],
    this.selectedRoomId,
    super.key,
  });

  /// List of employees for the selection field.
  final List<EmployeeEntity> employees;

  /// List of categories for the selection field.
  final List<CategoryEntity> categories;

  /// List of rooms for the selection field.
  final List<RoomEntity> rooms;

  /// The ID of the currently selected employee.
  final int? selectedEmployeeId;

  /// The IDs of the currently selected categories.
  final List<int> selectedCategoryIds;

  /// The ID of the currently selected room.
  final int? selectedRoomId;

  /// Callback triggered when an employee is selected.
  final void Function(int?) onEmployeeSelected;

  /// Callback triggered when categories are selected.
  final void Function(List<int>) onCategoriesSelected;

  /// Callback triggered when a room is selected.
  final void Function(int?) onRoomSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Resolve display names for current selections using entity extensions.
    final empName = employees.getNameById(
      selectedEmployeeId,
      fallback: l10n.invForm_notSelected,
    );
    final roomName = rooms.getNameById(
      selectedRoomId,
      fallback: l10n.invForm_notSelected,
    );

    return Column(
      children: [
        // Selection field for the responsible person.
        InventorySelectionField<EmployeeEntity>(
          label: l10n.invForm_responsibleLabel,
          selectedName: empName,
          icon: Icons.person,
          items: employees,
          selectedId: selectedEmployeeId,
          itemName: (e) => e.name,
          itemId: (e) => e.id,
          onSelected: (id) => onEmployeeSelected(id),
        ),
        const SizedBox(height: 16),
        // Selection field for the item category.
        InventoryMultiSelectionField<CategoryEntity>(
          label: l10n.invForm_categoryLabel,
          icon: Icons.category,
          items: categories,
          selectedIds: selectedCategoryIds,
          itemName: (c) => c.name,
          itemId: (c) => c.id,
          onChanged: onCategoriesSelected,
        ),
        const SizedBox(height: 16),
        // Selection field for the item's location (room).
        InventorySelectionField<RoomEntity>(
          label: l10n.invForm_roomLabel,
          selectedName: roomName,
          icon: Icons.room,
          items: rooms,
          selectedId: selectedRoomId,
          itemName: (r) => r.name,
          itemId: (r) => r.id,
          onSelected: (id) => onRoomSelected(id),
        ),
      ],
    );
  }
}
