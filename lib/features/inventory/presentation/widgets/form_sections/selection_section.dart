import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class SelectionSection extends StatelessWidget {
  final List<EmployeeModel> employees;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final int? selectedEmployeeId;
  final int? selectedCategoryId;
  final int? selectedRoomId;
  final void Function(int?) onEmployeeSelected;
  final void Function(int?) onCategorySelected;
  final void Function(int?) onRoomSelected;

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

  @override
  Widget build(BuildContext context) {
    final empName =
        employees.where((e) => e.id == selectedEmployeeId).firstOrNull?.name ??
        AppStrings.createInventory.notSelected;
    final catName =
        categories.where((c) => c.id == selectedCategoryId).firstOrNull?.name ??
        AppStrings.createInventory.notSelected;
    final roomName =
        rooms.where((r) => r.id == selectedRoomId).firstOrNull?.name ??
        AppStrings.createInventory.notSelected;

    return Column(
      children: [
        InventorySelectionField<EmployeeModel>(
          label: AppStrings.createInventory.responsibleLabel,
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
          label: AppStrings.createInventory.categoryLabel,
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
          label: AppStrings.createInventory.roomLabel,
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
