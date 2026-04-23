import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class CreateInventoryPage extends StatefulWidget {
  final InventoryEntity? editTarget;
  const CreateInventoryPage({super.key, this.editTarget});

  @override
  State<CreateInventoryPage> createState() => _CreateInventoryPageState();
}

class _CreateInventoryPageState extends State<CreateInventoryPage> {
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
  
  List<EmployeeModel> _employees = [];
  List<CategoryModel> _categories = [];
  List<RoomModel> _rooms = [];


  
  @override
  void initState() {
    super.initState();
    _inventoryIdToEdit = widget.editTarget?.id ?? 0;
    
    if (widget.editTarget != null) {
      _barcodeController.text = widget.editTarget!.barcode ?? '';
      _nameController.text = widget.editTarget!.name;
      _inventoryNumberController.text = widget.editTarget!.inventoryNumber ?? '';
      _quantityController.text = widget.editTarget!.quantity.toString();
      _descriptionController.text = widget.editTarget!.description ?? '';
      _selectedDate = widget.editTarget!.dateAdded;
      _selectedEmployeeId = widget.editTarget!.employeeId;
      _selectedCategoryId = widget.editTarget!.categoryId;
      _selectedRoomId = widget.editTarget!.roomId;
    }
    
    _loadData();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.editTarget == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('initialBarcode') && _barcodeController.text.isEmpty) {
        _barcodeController.text = args['initialBarcode'] as String;
      }
    }
  }

  Future<void> _loadData() async {
    final empSource = context.read<EmployeesLocalDataSourceImpl>();
    final roomSource = context.read<RoomsLocalDataSourceImpl>();
    final catSource = context.read<CategoriesLocalDataSourceImpl>();

    final employees = await empSource.getEmployees();
    final rooms = await roomSource.getRooms();
    final categories = await catSource.getCategories();

    setState(() {
      _employees = employees;
      _rooms = rooms;
      _categories = categories;

      // Set defaults based on requested names
      if (_selectedEmployeeId == null) {
        final defEmp = _employees.where((e) => e.name == 'Администратор').firstOrNull;
        if (defEmp != null) _selectedEmployeeId = defEmp.id;
      }
      
      if (_selectedRoomId == null) {
        final defRoom = _rooms.where((e) => e.name == 'Не определено').firstOrNull;
        if (defRoom != null) _selectedRoomId = defRoom.id;
      }
      
      if (_selectedCategoryId == null) {
        final defCat = _categories.where((e) => e.name == 'Не определено').firstOrNull;
        if (defCat != null) _selectedCategoryId = defCat.id;
      }
    });
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

  void _selectDate() async {
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

      if (widget.editTarget != null) {
        context.read<InventoryBloc>().add(UpdateInventoryEvent(inventory));
      } else {
        context.read<InventoryBloc>().add(CreateInventoryEvent(inventory));
      }
      
      Navigator.pop(context); // close form
    }
  }

  @override
  Widget build(BuildContext context) {
    final empName = _employees.where((e) => e.id == _selectedEmployeeId).firstOrNull?.name ?? AppStrings.createInventory.notSelected;
    final catName = _categories.where((c) => c.id == _selectedCategoryId).firstOrNull?.name ?? AppStrings.createInventory.notSelected;
    final roomName = _rooms.where((r) => r.id == _selectedRoomId).firstOrNull?.name ?? AppStrings.createInventory.notSelected;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editTarget == null ? AppStrings.createInventory.appBarCreateTitle : AppStrings.createInventory.appBarEditTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barcode output & scan button
              InventoryBarcodeField(
                controller: _barcodeController,
                onScanPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => InventoryBarcodeInputDialog(
                      initialBarcode: _barcodeController.text,
                      onBarcodeSaved: (barcode) {
                        setState(() {
                          _barcodeController.text = barcode;
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Name field
              InventoryTextField(
                controller: _nameController,
                labelText: AppStrings.createInventory.nameFieldLabel,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return AppStrings.createInventory.nameRequiredError;
                  if (value.length < 3) return AppStrings.createInventory.minLength3Error;
                  if (value.length > 50) return AppStrings.createInventory.maxLength50Error;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Inventory Number
              InventoryTextField(
                controller: _inventoryNumberController,
                labelText: AppStrings.createInventory.inventoryNumberFieldLabel,
                validator: (value) {
                  if (value != null && value.length > 50) return AppStrings.createInventory.maxLength50Error;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quantity
              InventoryTextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                labelText: AppStrings.createInventory.quantityFieldLabel,
                validator: (value) {
                  if (value == null || value.isEmpty) return AppStrings.createInventory.quantityRequiredError;
                  final qty = int.tryParse(value);
                  if (qty == null || qty < 1 || qty > 999) return AppStrings.createInventory.quantityRangeError;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Responsible
              InventorySelectionField<EmployeeModel>(
                label: AppStrings.createInventory.responsibleLabel,
                selectedName: empName,
                icon: Icons.person,
                items: _employees,
                selectedId: _selectedEmployeeId,
                itemName: (e) => e.name,
                itemId: (e) => e.id,
                onSelected: (id) => setState(() => _selectedEmployeeId = id),
              ),
              const SizedBox(height: 16),

              // Category
              InventorySelectionField<CategoryModel>(
                label: AppStrings.createInventory.categoryLabel,
                selectedName: catName,
                icon: Icons.category,
                items: _categories,
                selectedId: _selectedCategoryId,
                itemName: (c) => c.name,
                itemId: (c) => c.id,
                onSelected: (id) => setState(() => _selectedCategoryId = id),
              ),
              const SizedBox(height: 16),

              // Room
              InventorySelectionField<RoomModel>(
                label: AppStrings.createInventory.roomLabel,
                selectedName: roomName,
                icon: Icons.room,
                items: _rooms,
                selectedId: _selectedRoomId,
                itemName: (r) => r.name,
                itemId: (r) => r.id,
                onSelected: (id) => setState(() => _selectedRoomId = id),
              ),
              const SizedBox(height: 16),

              // Description
              InventoryTextField(
                controller: _descriptionController,
                maxLines: 3,
                labelText: AppStrings.createInventory.descriptionFieldLabel,
                validator: (value) {
                  if (value != null && value.length > 500) return AppStrings.createInventory.maxLength500Error;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date field
              InventoryActionField(
                label: AppStrings.createInventory.dateAddedLabel,
                valueText: DateFormat('dd.MM.yyyy').format(_selectedDate),
                icon: Icons.calendar_today,
                onTap: _selectDate,
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(AppStrings.createInventory.saveButton),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppStrings.createInventory.cancelButton),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
