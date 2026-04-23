import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class CreateInventoryForm extends StatefulWidget {
  const CreateInventoryForm({super.key, this.editTarget});

  final InventoryEntity? editTarget;

  @override
  State<CreateInventoryForm> createState() => _CreateInventoryFormState();
}

class _CreateInventoryFormState extends State<CreateInventoryForm>
    with CreateInventoryFormStateMixin {
  void _submitForm() {
    if (formKey.currentState!.validate()) {
      context.read<InventoryFormBloc>().add(
            SubmitInventoryEvent(
              inventory: getInventoryData(),
              isEdit: widget.editTarget != null,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryFormBloc, InventoryFormState>(
      listener: (context, state) {
        if (state is InventoryFormMetadataLoaded && widget.editTarget == null) {
          setState(() {
            selectedEmployeeId ??= state.defaultEmployeeId;
            selectedCategoryId ??= state.defaultCategoryId;
            selectedRoomId ??= state.defaultRoomId;
          });
        }
      },
      builder: (context, state) {
        if (state is InventoryFormLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final employees = state is InventoryFormMetadataLoaded ? state.employees : <EmployeeModel>[];
        final categories = state is InventoryFormMetadataLoaded ? state.categories : <CategoryModel>[];
        final rooms = state is InventoryFormMetadataLoaded ? state.rooms : <RoomModel>[];

        return CreateInventoryFormBody(
          formKey: formKey,
          barcodeController: barcodeController,
          nameController: nameController,
          inventoryNumberController: inventoryNumberController,
          quantityController: quantityController,
          descriptionController: descriptionController,
          selectedDate: selectedDate,
          selectedEmployeeId: selectedEmployeeId,
          selectedCategoryId: selectedCategoryId,
          selectedRoomId: selectedRoomId,
          employees: employees,
          categories: categories,
          rooms: rooms,
          onSelectDate: () => selectDate(),
          onSubmit: _submitForm,
          onCancel: () => Navigator.pop(context),
          onBarcodeSaved: (barcode) =>
              setState(() => barcodeController.text = barcode),
          onEmployeeSelected: (id) => setState(() => selectedEmployeeId = id),
          onCategorySelected: (id) => setState(() => selectedCategoryId = id),
          onRoomSelected: (id) => setState(() => selectedRoomId = id),
        );
      },
    );
  }
}
