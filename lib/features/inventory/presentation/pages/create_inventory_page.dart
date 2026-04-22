import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

  final MobileScannerController _scannerController = MobileScannerController();
  bool _isScanHandled = false;
  
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
    _scannerController.dispose();
    super.dispose();
  }

  void _showBarcodeScanDialog() {
    final localBarcodeController = TextEditingController(text: _barcodeController.text);
    _isScanHandled = false;

    showDialog(
      context: context,
      builder: (modalContext) => AlertDialog(
        title: const Text('Ввод штрихкода'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: localBarcodeController,
                decoration: InputDecoration(
                  labelText: 'Штрихкод',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Или отсканируйте камерой:'),
              const SizedBox(height: 12),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                clipBehavior: Clip.antiAlias,
                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) {
                    if (_isScanHandled) return;
                    if (capture.barcodes.isEmpty) return;
                    
                    final barcode = capture.barcodes.first.rawValue;
                    if (barcode == null || barcode.trim().isEmpty) return;

                    _isScanHandled = true;
                    // Scanning overrides the manual input
                    localBarcodeController.text = barcode;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Отсканировано!'), duration: Duration(seconds: 1)),
                    );
                    // Do not close automatically, user must press Save per requirements
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
               _isScanHandled = false; // allow scan again
               _scannerController.start();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Сбросить сканер'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(modalContext),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              _barcodeController.text = localBarcodeController.text;
              Navigator.pop(modalContext);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
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
  
  void _selectEmployee() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: _employees.map((e) => ListTile(
          title: Text(e.name),
          selected: _selectedEmployeeId == e.id,
          onTap: () {
            setState(() => _selectedEmployeeId = e.id);
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }

  void _selectCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: _categories.map((c) => ListTile(
          title: Text(c.name),
          selected: _selectedCategoryId == c.id,
          onTap: () {
            setState(() => _selectedCategoryId = c.id);
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
  }

  void _selectRoom() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: _rooms.map((r) => ListTile(
          title: Text(r.name),
          selected: _selectedRoomId == r.id,
          onTap: () {
            setState(() => _selectedRoomId = r.id);
            Navigator.pop(context);
          },
        )).toList(),
      ),
    );
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
    final empName = _employees.where((e) => e.id == _selectedEmployeeId).firstOrNull?.name ?? 'Не выбрано';
    final catName = _categories.where((c) => c.id == _selectedCategoryId).firstOrNull?.name ?? 'Не выбрано';
    final roomName = _rooms.where((r) => r.id == _selectedRoomId).firstOrNull?.name ?? 'Не выбрано';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editTarget == null ? 'Создание предмета' : 'Редактирование предмета'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barcode output & scan button
              const Text('Штрихкод', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                   Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _barcodeController.text.isEmpty ? 'Нет кода' : _barcodeController.text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _showBarcodeScanDialog,
                    icon: const Icon(Icons.qr_code_2),
                    tooltip: 'Сканировать/Ввести',
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Введите название';
                  if (value.length < 3) return 'Минимум 3 символа';
                  if (value.length > 50) return 'Максимум 50 символов';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Inventory Number
              TextFormField(
                controller: _inventoryNumberController,
                decoration: InputDecoration(
                  labelText: 'Инвентарный номер',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length > 50) return 'Максимум 50 символов';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quantity
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Количество',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите количество';
                  final qty = int.tryParse(value);
                  if (qty == null || qty < 1 || qty > 999) return 'От 1 до 999';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Responsible
              const Text('Ответственный', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectEmployee,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(empName),
                      const Icon(Icons.person),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Category
              const Text('Категория', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectCategory,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(catName),
                      const Icon(Icons.category),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Room
              const Text('Помещение', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectRoom,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(roomName),
                      const Icon(Icons.room),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.length > 500) return 'Максимум 500 символов';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date field
              const Text('Дата постановки на учёт *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd.MM.yyyy').format(_selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Сохранить'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
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
