import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A header widget for the inventory list that provides searching and filtering.
///
/// Contains a [TextField] for name-based search and a [DropdownButtonFormField]
/// for category-based filtering. It dispatches search and filter events to the
/// [InventoryBloc].
class InventoryListHeader extends StatefulWidget {
  /// Creates an [InventoryListHeader].
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
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search input field with a clear button.
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.invList_searchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  return value.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            context
                                .read<InventoryBloc>()
                                .add(const LoadInventoriesEvent());
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
                context
                    .read<InventoryBloc>()
                    .add(SearchInventoriesByNameEvent(value));
              } else {
                context.read<InventoryBloc>().add(const LoadInventoriesEvent());
              }
            },
          ),
          const SizedBox(height: 12),
          // Category filter dropdown.
          BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
              if (state is InventoriesLoaded) {
                return DropdownButtonFormField<int?>(
                  isExpanded: true,
                  initialValue: state.categoryFilter,
                  decoration: InputDecoration(
                    labelText: l10n.invList_filterByCategoryLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(l10n.invList_showAllCategories),
                    ),
                    ...state.categories.map(
                      (CategoryEntity c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(
                          c.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    if (val == null) {
                      context
                          .read<InventoryBloc>()
                          .add(const ClearFiltersEvent());
                    } else {
                      context
                          .read<InventoryBloc>()
                          .add(FilterInventoriesByCategoryEvent(val));
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
