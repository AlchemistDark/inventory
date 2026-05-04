import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A scrollable list of inventory items.
///
/// Uses [ListView.builder] to efficiently render the items.
/// Responsible for mapping employee and room IDs to their respective names
/// using pre-computed maps for O(1) lookups.
class InventoryListView extends StatelessWidget {
  /// Creates an [InventoryListView].
  const InventoryListView({
    required this.items,
    required this.employeeMap,
    required this.roomMap,
    super.key,
  });

  /// The list of inventory items to display.
  final List<InventoryEntity> items;

  /// Map of employee IDs to their names for O(1) lookup.
  final Map<int, String> employeeMap;

  /// Map of room IDs to their names for O(1) lookup.
  final Map<int, String> roomMap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (items.isEmpty) {
      return Center(child: Text(l10n.invList_noItemsFilterMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        final employeeName = item.employeeId != null
            ? (employeeMap[item.employeeId] ?? l10n.invList_notSpecifiedMale)
            : l10n.invList_notSpecifiedMale;

        final roomName = item.roomId != null
            ? (roomMap[item.roomId] ?? l10n.invList_notSpecified)
            : l10n.invList_notSpecified;

        return InventoryListItem(
          inventory: item,
          employeeName: employeeName,
          roomName: roomName,
        );
      },
    );
  }
}
