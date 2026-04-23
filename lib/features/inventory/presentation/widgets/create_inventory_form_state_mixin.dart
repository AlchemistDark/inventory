import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

mixin CreateInventoryFormStateMixin on State<CreateInventoryForm> {
  final formKey = GlobalKey<FormState>();
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final inventoryNumberController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  final descriptionController = TextEditingController();

  int inventoryIdToEdit = 0;
  DateTime selectedDate = DateTime.now();
  int? selectedEmployeeId;
  int? selectedCategoryId;
  int? selectedRoomId;

  @override
  void initState() {
    super.initState();
    inventoryIdToEdit = widget.editTarget?.id ?? 0;

    if (widget.editTarget != null) {
      barcodeController.text = widget.editTarget!.barcode ?? '';
      nameController.text = widget.editTarget!.name;
      inventoryNumberController.text = widget.editTarget!.inventoryNumber ?? '';
      quantityController.text = widget.editTarget!.quantity.toString();
      descriptionController.text = widget.editTarget!.description ?? '';
      selectedDate = widget.editTarget!.dateAdded;
      selectedEmployeeId = widget.editTarget!.employeeId;
      selectedCategoryId = widget.editTarget!.categoryId;
      selectedRoomId = widget.editTarget!.roomId;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.editTarget == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('initialBarcode') && barcodeController.text.isEmpty) {
        barcodeController.text = args['initialBarcode'] as String;
      }
    }
  }

  @override
  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    inventoryNumberController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      lastDate: DateTime.now(),
    );
    if (!mounted) {
      return;
    }
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  InventoryEntity getInventoryData() {
    return InventoryEntity(
      id: inventoryIdToEdit,
      barcode: barcodeController.text.trim().isEmpty ? null : barcodeController.text.trim(),
      name: nameController.text.trim(),
      inventoryNumber: inventoryNumberController.text.trim().isEmpty ? null : inventoryNumberController.text.trim(),
      quantity: int.parse(quantityController.text),
      description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
      dateAdded: selectedDate,
      employeeId: selectedEmployeeId,
      roomId: selectedRoomId,
      categoryId: selectedCategoryId,
      createdAt: widget.editTarget?.createdAt ?? DateTime.now(),
    );
  }
}
