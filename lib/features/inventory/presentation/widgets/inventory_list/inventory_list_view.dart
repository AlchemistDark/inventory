import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A scrollable list of inventory items.
///
/// Uses [ListView.builder] to efficiently render the [state.filteredInventories].
/// Responsible for mapping employee and room IDs to their respective names
/// before passing them to individual [InventoryListItem]s.
class InventoryListView extends StatelessWidget {
  /// Creates an [InventoryListView].
  const InventoryListView({
    required this.items,
    required this.employees,
    required this.rooms,
    super.key,
  });

  /// The list of inventory items to display.
  final List<InventoryEntity> items;

  /// List of employees for name lookup.
  final List<EmployeeEntity> employees;

  /// List of rooms for name lookup.
  final List<RoomEntity> rooms;

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
        final employeeName = employees.getNameById(
          item.employeeId,
          fallback: l10n.invList_notSpecifiedMale,
        );
        final roomName = rooms.getNameById(
          item.roomId,
          fallback: l10n.invList_notSpecified,
        );

        return InventoryListItem(
          inventory: item,
          employeeName: employeeName,
          roomName: roomName,
        );
      },
    );
  }
}
