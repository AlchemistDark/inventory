import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

class SelectionSection extends StatelessWidget {
  const SelectionSection({
    required this.employees,
    required this.categories,
    required this.rooms,
    required this.onEmployeeSelected,
    required this.onCategorySelected,
    required this.onRoomSelected,
    this.selectedEmployeeId,
    this.selectedCategoryId,
    this.selectedRoomId,
    super.key,
  });

  final List<EmployeeModel> employees;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final int? selectedEmployeeId;
  final int? selectedCategoryId;
  final int? selectedRoomId;
  final void Function(int?) onEmployeeSelected;
  final void Function(int?) onCategorySelected;
  final void Function(int?) onRoomSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final empName =
        employees.where((e) => e.id == selectedEmployeeId).firstOrNull?.name ??
        l10n.invForm_notSelected;
    final catName =
        categories.where((c) => c.id == selectedCategoryId).firstOrNull?.name ??
        l10n.invForm_notSelected;
    final roomName =
        rooms.where((r) => r.id == selectedRoomId).firstOrNull?.name ??
        l10n.invForm_notSelected;

    return Column(
      children: [
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
        InventorySelectionField<CategoryModel>(
          label: l10n.invForm_categoryLabel,
          selectedName: catName,
          icon: Icons.category,
          items: categories,
          selectedId: selectedCategoryId,
          itemName: (c) => c.name,
          itemId: (c) => c.id,
          onSelected: onCategorySelected,
        ),
        const SizedBox(height: 16),
        InventorySelectionField<RoomModel>(
          label: l10n.invForm_roomLabel,
          selectedName: roomName,
          icon: Icons.room,
          items: rooms,
          selectedId: selectedRoomId,
          itemName: (r) => r.name,
          itemId: (r) => r.id,
          onSelected: onRoomSelected,
        ),
      ],
    );
  }
}
