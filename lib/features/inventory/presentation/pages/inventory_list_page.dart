import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryListPage extends StatefulWidget {
  const InventoryListPage({super.key});

  @override
  State<InventoryListPage> createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  final _searchController = TextEditingController();
  
  Map<int, String> _employeeMap = {};
  Map<int, String> _roomMap = {};
  Map<int, String> _categoryMap = {};

  @override
  void initState() {
    super.initState();
    _loadMaps();
    context.read<InventoryBloc>().add(const InitializeInventoriesEvent());
  }
  
  Future<void> _loadMaps() async {
    final empSource = context.read<EmployeesLocalDataSourceImpl>();
    final roomSource = context.read<RoomsLocalDataSourceImpl>();
    final catSource = context.read<CategoriesLocalDataSourceImpl>();

    final employees = await empSource.getEmployees();
    final rooms = await roomSource.getRooms();
    final categories = await catSource.getCategories();

    setState(() {
      _employeeMap = {for (var e in employees) e.id: e.name};
      _roomMap = {for (var r in rooms) r.id: r.name};
      _categoryMap = {for (var c in categories) c.id: c.name};
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDetail(InventoryEntity inventory) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(inventory.name)),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateInventoryPage(editTarget: inventory),
                  ),
                );
              },
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Название:', inventory.name),
              _buildDetailRow('Штрихкод:', inventory.barcode ?? 'Не указан'),
              _buildDetailRow('Инвентарный №:', inventory.inventoryNumber ?? 'Не указан'),
              _buildDetailRow('Количество:', '${inventory.quantity}'),
              _buildDetailRow('Помещение:', _roomMap[inventory.roomId] ?? 'Не указано'),
              _buildDetailRow('Ответственный:', _employeeMap[inventory.employeeId] ?? 'Не указан'),
              _buildDetailRow('Категория:', _categoryMap[inventory.categoryId] ?? 'Не указана'),
              _buildDetailRow('Дата постановки:', inventory.dateAdded.toString().split(' ')[0]),
              if (inventory.description != null)
                _buildDetailRow('Описание:', inventory.description!),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инвентарь'),
      ),
      body: Column(
        children: [
          // Filter section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Поиск по штрихкоду, инвентарному номеру или названию',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<InventoryBloc>().add(const LoadInventoriesEvent());
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    // ToDo Удалить
                    setState(() {});
                    if (value.trim().isNotEmpty) {
                      context.read<InventoryBloc>().add(SearchInventoriesByNameEvent(value));
                    } else {
                      context.read<InventoryBloc>().add(const LoadInventoriesEvent());
                    }
                  },
                ),
                const SizedBox(height: 12),
                BlocBuilder<InventoryBloc, InventoryState>(
                  builder: (context, state) {
                    int? currentCategory;
                    if (state is InventoriesLoaded) {
                      currentCategory = state.categoryFilter;
                    }
                    
                    return DropdownButtonFormField<int?>(
                      value: currentCategory,
                      decoration: InputDecoration(
                        labelText: 'Фильтр по категории',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Все категории')),
                        ..._categoryMap.entries.map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        )),
                      ],
                      onChanged: (val) {
                        if (val == null) {
                          context.read<InventoryBloc>().add(const ClearFiltersEvent());
                        } else {
                          context.read<InventoryBloc>().add(FilterInventoriesByCategoryEvent(val));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (context, state) {
                if (state is InventoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InventoriesLoaded) {
                  var displayList = state.inventories;
                  
                  // Перенести в блок. ToDo
                  if (state.categoryFilter != null) {
                    displayList = displayList.where((i) => i.categoryId == state.categoryFilter).toList();
                  }

                  if (displayList.isEmpty) {
                    return const Center(
                      child: Text('Нет предметов, удовлетворяющих фильтру'),
                    );
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final item = displayList[index];
                      // Возможно как-то разбить
                      final String qtyText = item.quantity > 0 ? '(${item.quantity}) ' : '';
                      final String invNumText = item.inventoryNumber != null ? '${item.inventoryNumber} ' : 'Без номера ';
                      final titleText = '$invNumText$qtyText${item.name}';
                      
                      final String roomAndEmp = 'Помещение: ${_roomMap[item.roomId] ?? "Не указано"}, Отв.: ${_employeeMap[item.employeeId] ?? "Не указан"}';

                      return GestureDetector(
                        onTap: () => _showDetail(item),
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        titleText,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  roomAndEmp,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is InventoryError) {
                  return Center(child: Text('Ошибка: ${state.message}'));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateInventoryPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
