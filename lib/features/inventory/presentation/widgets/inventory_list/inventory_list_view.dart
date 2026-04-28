import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A scrollable list of inventory items.
///
/// Uses [ListView.builder] to efficiently render the [state.filteredInventories].
/// Responsible for mapping employee and room IDs to their respective names
/// before passing them to individual [InventoryListItem]s.
class InventoryListView extends StatelessWidget {
  /// Creates an [InventoryListView] with the given [state].
  const InventoryListView({
    required this.state,
    super.key,
  });

  /// The loaded state containing all inventory items and metadata.
  final InventoriesLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayList = state.filteredInventories;

    if (displayList.isEmpty) {
      return Center(child: Text(l10n.invList_noItemsFilterMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final item = displayList[index];
        final employeeName =
            state.employeeMap[item.employeeId] ?? l10n.invList_notSpecifiedMale;

        return InventoryListItem(
          inventory: item,
          employeeName: employeeName,
          roomName: ' ',
        );
      },
    );
  }
}
