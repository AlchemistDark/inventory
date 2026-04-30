import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// The visual body of the inventory creation and editing form.
///
/// This widget organizes the form into distinct sections (Barcode, Basic Info,
/// Selections, and Footer) and provides a scrollable layout. It is stateless
/// and relies on parent-provided controllers and callbacks.
class CreateInventoryFormBody extends StatelessWidget {
  /// Creates a [CreateInventoryFormBody].
  const CreateInventoryFormBody({
    required this.formKey,
    required this.barcodeController,
    required this.nameController,
    required this.inventoryNumberController,
    required this.quantityController,
    required this.descriptionController,
    required this.selectedDate,
    required this.employees,
    required this.categories,
    required this.rooms,
    required this.onSelectDate,
    required this.onSubmit,
    required this.onCancel,
    required this.onBarcodeSaved,
    required this.onEmployeeSelected,
    required this.onCategoriesSelected,
    required this.onRoomSelected,
    this.selectedEmployeeId,
    this.selectedCategoryIds = const [],
    this.selectedRoomId,
    super.key,
  });

  /// Key for the [Form] widget, used for validation.
  final GlobalKey<FormState> formKey;

  /// Controller for the barcode field.
  final TextEditingController barcodeController;

  /// Controller for the item name field.
  final TextEditingController nameController;

  /// Controller for the inventory number field.
  final TextEditingController inventoryNumberController;

  /// Controller for the quantity field.
  final TextEditingController quantityController;

  /// Controller for the description field.
  final TextEditingController descriptionController;

  /// The currently selected date for the inventory item.
  final DateTime selectedDate;

  /// The ID of the currently selected employee.
  final int? selectedEmployeeId;

  /// The IDs of the currently selected categories.
  final List<int> selectedCategoryIds;

  /// The ID of the currently selected room.
  final int? selectedRoomId;

  /// List of employees to populate the selection field.
  final List<EmployeeEntity> employees;

  /// List of categories to populate the selection field.
  final List<CategoryEntity> categories;

  /// List of rooms to populate the selection field.
  final List<RoomEntity> rooms;

  /// Callback to trigger date selection.
  final VoidCallback onSelectDate;

  /// Callback to trigger form submission.
  final VoidCallback onSubmit;

  /// Callback to cancel form entry and go back.
  final VoidCallback onCancel;

  /// Callback triggered when a barcode is scanned and saved.
  final ValueChanged<String> onBarcodeSaved;

  /// Callback triggered when an employee is selected.
  final ValueChanged<int?> onEmployeeSelected;

  /// Callback triggered when categories are selected.
  final ValueChanged<List<int>> onCategoriesSelected;

  /// Callback triggered when a room is selected.
  final ValueChanged<int?> onRoomSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BarcodeSection(
              controller: barcodeController,
              onBarcodeSaved: onBarcodeSaved,
            ),
            const SizedBox(height: 16),
            BasicInfoSection(
              nameController: nameController,
              inventoryNumberController: inventoryNumberController,
              quantityController: quantityController,
            ),
            const SizedBox(height: 16),
            SelectionSection(
              employees: employees,
              categories: categories,
              rooms: rooms,
              selectedEmployeeId: selectedEmployeeId,
              selectedCategoryIds: selectedCategoryIds,
              selectedRoomId: selectedRoomId,
              onEmployeeSelected: onEmployeeSelected,
              onCategoriesSelected: onCategoriesSelected,
              onRoomSelected: onRoomSelected,
            ),
            const SizedBox(height: 16),
            FooterSection(
              descriptionController: descriptionController,
              selectedDate: selectedDate,
              onSelectDate: onSelectDate,
              onSubmit: onSubmit,
              onCancel: onCancel,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
