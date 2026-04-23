import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

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
      _employeeMap = {for (final e in employees) e.id: e.name};
      _roomMap = {for (final r in rooms) r.id: r.name};
      _categoryMap = {for (final c in categories) c.id: c.name};
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDetail(InventoryEntity inventory) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (context) => InventoryDetailsPage(inventory: inventory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.inventoryList.appBarTitle)),
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
                    hintText: AppStrings.inventoryList.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              context.read<InventoryBloc>().add(
                                const LoadInventoriesEvent(),
                              );
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
                    // TODO: Удалить
                    setState(() {});
                    if (value.trim().isNotEmpty) {
                      context.read<InventoryBloc>().add(
                        SearchInventoriesByNameEvent(value),
                      );
                    } else {
                      context.read<InventoryBloc>().add(
                        const LoadInventoriesEvent(),
                      );
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
                      initialValue: currentCategory,
                      decoration: InputDecoration(
                        labelText:
                            AppStrings.inventoryList.filterByCategoryLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: null,
                          child: Text(
                            AppStrings.inventoryList.showAllCategories,
                          ),
                        ),
                        ..._categoryMap.entries.map(
                          (e) => DropdownMenuItem(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        ),
                      ],
                      onChanged: (val) {
                        if (val == null) {
                          context.read<InventoryBloc>().add(
                            const ClearFiltersEvent(),
                          );
                        } else {
                          context.read<InventoryBloc>().add(
                            FilterInventoriesByCategoryEvent(val),
                          );
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

                  // TODO: Перенести в блок
                  if (state.categoryFilter != null) {
                    displayList = displayList
                        .where((i) => i.categoryId == state.categoryFilter)
                        .toList();
                  }

                  if (displayList.isEmpty) {
                    return Center(
                      child: Text(
                        AppStrings.inventoryList.noItemsFilterMessage,
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final item = displayList[index];
                      // Возможно как-то разбить
                      final String qtyText = item.quantity > 0
                          ? '(${item.quantity}) '
                          : '';
                      final String invNumText = item.inventoryNumber != null
                          ? '${item.inventoryNumber} '
                          : '${AppStrings.inventoryList.noInventoryNumber} ';
                      final titleText = '$invNumText$qtyText${item.name}';

                      final String roomAndEmp =
                          '${AppStrings.inventoryList.detailRoomLabel} ${_roomMap[item.roomId] ?? AppStrings.inventoryList.notSpecified}, ${AppStrings.inventoryList.detailResponsibleLabel} ${_employeeMap[item.employeeId] ?? AppStrings.inventoryList.notSpecifiedMale}';

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                  return Center(
                    child: Text(
                      '${AppStrings.inventoryList.errorMessagePrefix}${state.message}',
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const CreateInventoryPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
