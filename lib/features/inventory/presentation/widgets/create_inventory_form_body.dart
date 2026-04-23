import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class CreateInventoryFormBody extends StatelessWidget {
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
    required this.onCategorySelected,
    required this.onRoomSelected,
    this.selectedEmployeeId,
    this.selectedCategoryId,
    this.selectedRoomId,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController barcodeController;
  final TextEditingController nameController;
  final TextEditingController inventoryNumberController;
  final TextEditingController quantityController;
  final TextEditingController descriptionController;
  final DateTime selectedDate;
  final int? selectedEmployeeId;
  final int? selectedCategoryId;
  final int? selectedRoomId;
  final List<EmployeeModel> employees;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final VoidCallback onSelectDate;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final ValueChanged<String> onBarcodeSaved;
  final ValueChanged<int?> onEmployeeSelected;
  final ValueChanged<int?> onCategorySelected;
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
              selectedCategoryId: selectedCategoryId,
              selectedRoomId: selectedRoomId,
              onEmployeeSelected: onEmployeeSelected,
              onCategorySelected: onCategorySelected,
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
