import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class CreateInventoryForm extends StatefulWidget {
  final InventoryEntity? editTarget;

  const CreateInventoryForm({super.key, this.editTarget});

  @override
  State<CreateInventoryForm> createState() => _CreateInventoryFormState();
}

class _CreateInventoryFormState extends State<CreateInventoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _inventoryNumberController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  int? _selectedEmployeeId;
  int? _selectedCategoryId;
  int? _selectedRoomId;
  late int _inventoryIdToEdit;

  @override
  void initState() {
    super.initState();
    _inventoryIdToEdit = widget.editTarget?.id ?? 0;

    if (widget.editTarget != null) {
      _barcodeController.text = widget.editTarget!.barcode ?? '';
      _nameController.text = widget.editTarget!.name;
      _inventoryNumberController.text =
          widget.editTarget!.inventoryNumber ?? '';
      _quantityController.text = widget.editTarget!.quantity.toString();
      _descriptionController.text = widget.editTarget!.description ?? '';
      _selectedDate = widget.editTarget!.dateAdded;
      _selectedEmployeeId = widget.editTarget!.employeeId;
      _selectedCategoryId = widget.editTarget!.categoryId;
      _selectedRoomId = widget.editTarget!.roomId;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.editTarget == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null &&
          args.containsKey('initialBarcode') &&
          _barcodeController.text.isEmpty) {
        _barcodeController.text = args['initialBarcode'] as String;
      }
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _nameController.dispose();
    _inventoryNumberController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final inventory = InventoryEntity(
        id: _inventoryIdToEdit,
        barcode: _barcodeController.text.trim().isEmpty
            ? null
            : _barcodeController.text.trim(),
        name: _nameController.text.trim(),
        inventoryNumber: _inventoryNumberController.text.trim().isEmpty
            ? null
            : _inventoryNumberController.text.trim(),
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        dateAdded: _selectedDate,
        employeeId: _selectedEmployeeId,
        roomId: _selectedRoomId,
        categoryId: _selectedCategoryId,
        createdAt: widget.editTarget?.createdAt ?? DateTime.now(),
      );

      context.read<InventoryFormBloc>().add(
        SubmitInventoryEvent(
          inventory: inventory,
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
            _selectedEmployeeId ??= state.defaultEmployeeId;
            _selectedCategoryId ??= state.defaultCategoryId;
            _selectedRoomId ??= state.defaultRoomId;
          });
        }
      },
      builder: (context, state) {
        if (state is InventoryFormLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<EmployeeModel> employees = [];
        List<CategoryModel> categories = [];
        List<RoomModel> rooms = [];

        if (state is InventoryFormMetadataLoaded) {
          employees = state.employees;
          categories = state.categories;
          rooms = state.rooms;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BarcodeSection(
                  controller: _barcodeController,
                  onBarcodeSaved: (barcode) =>
                      setState(() => _barcodeController.text = barcode),
                ),
                const SizedBox(height: 16),
                BasicInfoSection(
                  nameController: _nameController,
                  inventoryNumberController: _inventoryNumberController,
                  quantityController: _quantityController,
                ),
                const SizedBox(height: 16),
                SelectionSection(
                  employees: employees,
                  categories: categories,
                  rooms: rooms,
                  selectedEmployeeId: _selectedEmployeeId,
                  selectedCategoryId: _selectedCategoryId,
                  selectedRoomId: _selectedRoomId,
                  onEmployeeSelected: (id) =>
                      setState(() => _selectedEmployeeId = id),
                  onCategorySelected: (id) =>
                      setState(() => _selectedCategoryId = id),
                  onRoomSelected: (id) => setState(() => _selectedRoomId = id),
                ),
                const SizedBox(height: 16),
                FooterSection(
                  descriptionController: _descriptionController,
                  selectedDate: _selectedDate,
                  onSelectDate: _selectDate,
                  onSubmit: _submitForm,
                  onCancel: () => Navigator.pop(context),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
