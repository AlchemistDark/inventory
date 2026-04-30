import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A mixin that manages the complex state of the inventory creation form.
///
/// It handles text controllers lifecycle, date picking, and data extraction
/// for the [CreateInventoryForm]. It is designed to be used with a
/// [State] that is part of [CreateInventoryForm].
mixin CreateInventoryFormStateMixin on State<CreateInventoryForm> {
  /// Global key for the form validation.
  final formKey = GlobalKey<FormState>();

  /// Controller for the barcode input.
  final barcodeController = TextEditingController();

  /// Controller for the inventory item name.
  final nameController = TextEditingController();

  /// Controller for the unique inventory number.
  final inventoryNumberController = TextEditingController();

  /// Controller for the item quantity, defaults to '1'.
  final quantityController = TextEditingController(text: '1');

  /// Controller for the item description or notes.
  final descriptionController = TextEditingController();

  /// The ID of the inventory item being edited (0 if creating a new one).
  int inventoryIdToEdit = 0;

  /// The date the item was added or inventoried.
  DateTime selectedDate = DateTime.now();

  /// The currently selected employee ID.
  int? selectedEmployeeId;

  /// The currently selected category IDs.
  List<int> selectedCategoryIds = [];

  /// The currently selected room ID.
  int? selectedRoomId;

  @override
  void initState() {
    super.initState();
    inventoryIdToEdit = widget.editTarget?.id ?? 0;

    // Pre-populate controllers and state if editing an existing item.
    if (widget.editTarget != null) {
      barcodeController.text = widget.editTarget!.barcode ?? '';
      nameController.text = widget.editTarget!.name;
      inventoryNumberController.text = widget.editTarget!.inventoryNumber ?? '';
      quantityController.text = widget.editTarget!.quantity.toString();
      descriptionController.text = widget.editTarget!.description ?? '';
      selectedDate = widget.editTarget!.dateAdded;
      selectedEmployeeId = widget.editTarget!.employeeId;
      selectedCategoryIds = List<int>.of(widget.editTarget!.categoryIds);
      selectedRoomId = widget.editTarget!.roomId;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Handle initial barcode passed via navigation arguments (e.g., from home screen).
    if (widget.editTarget == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null &&
          args.containsKey('initialBarcode') &&
          barcodeController.text.isEmpty) {
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

  /// Opens a date picker and updates [selectedDate] if a new date is chosen.
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

  /// Collects all form data into an [InventoryEntity] for submission.
  InventoryEntity getInventoryData() {
    return InventoryEntity(
      id: inventoryIdToEdit,
      barcode: barcodeController.text.trim().isEmpty
          ? null
          : barcodeController.text.trim(),
      name: nameController.text.trim(),
      inventoryNumber: inventoryNumberController.text.trim().isEmpty
          ? null
          : inventoryNumberController.text.trim(),
      quantity: int.parse(quantityController.text),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      dateAdded: selectedDate,
      employeeId: selectedEmployeeId,
      roomId: selectedRoomId,
      categoryIds: selectedCategoryIds,
      createdAt: widget.editTarget?.createdAt ?? DateTime.now(),
    );
  }
}
