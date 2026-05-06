import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A stateful widget that provides a form for creating or editing inventory items.
///
/// This widget coordinates the form state through [CreateInventoryFormStateMixin]
/// and interacts with [InventoryFormBloc] for data persistence and metadata loading.
class CreateInventoryForm extends StatefulWidget {
  /// Creates a [CreateInventoryForm].
  ///
  /// If [editTarget] is provided, the form will be initialized with its values.
  const CreateInventoryForm({super.key, this.editTarget});

  /// The existing inventory item to be edited, if any.
  final InventoryEntity? editTarget;

  @override
  State<CreateInventoryForm> createState() => _CreateInventoryFormState();
}

class _CreateInventoryFormState extends State<CreateInventoryForm>
    with CreateInventoryFormStateMixin {
  /// Validates the form and dispatches a submission event to the BLoC.
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
    return BlocBuilder<InventoryFormBloc, InventoryFormState>(
      builder: (context, state) {
        if (state is InventoryFormLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final employees = state is InventoryFormMetadataLoaded
            ? state.employees
            : <EmployeeEntity>[];
        final categories = state is InventoryFormMetadataLoaded
            ? state.categories
            : <CategoryEntity>[];
        final rooms = state is InventoryFormMetadataLoaded
            ? state.rooms
            : <RoomEntity>[];

        return CreateInventoryFormBody(
          formKey: formKey,
          barcodeController: barcodeController,
          nameController: nameController,
          inventoryNumberController: inventoryNumberController,
          quantityController: quantityController,
          descriptionController: descriptionController,
          selectedDate: selectedDate,
          selectedEmployeeId: selectedEmployeeId,
          selectedCategoryIds: selectedCategoryIds,
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
          onCategoriesSelected: (ids) {
            setState(() {
              selectedCategoryIds = InventoryEntity.cleanCategoryIds(ids);
            });
          },
          onRoomSelected: (id) => setState(() => selectedRoomId = id),
        );
      },
    );
  }
}
