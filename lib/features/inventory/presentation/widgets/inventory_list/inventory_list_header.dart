import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class InventoryListHeader extends StatefulWidget {
  const InventoryListHeader({super.key});

  @override
  State<InventoryListHeader> createState() => _InventoryListHeaderState();
}

class _InventoryListHeaderState extends State<InventoryListHeader> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppStrings.inventoryList.searchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            context.read<InventoryBloc>().add(const LoadInventoriesEvent());
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : const SizedBox();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
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
              if (state is InventoriesLoaded) {
                return DropdownButtonFormField<int?>(
                  initialValue: state.categoryFilter,
                  decoration: InputDecoration(
                    labelText: AppStrings.inventoryList.filterByCategoryLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppStrings.inventoryList.showAllCategories),
                    ),
                    ...state.categories.map(
                      (c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    if (val == null) {
                      context.read<InventoryBloc>().add(const ClearFiltersEvent());
                    } else {
                      context.read<InventoryBloc>().add(FilterInventoriesByCategoryEvent(val));
                    }
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
