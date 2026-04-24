import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryListView extends StatelessWidget {
  const InventoryListView({
    required this.state,
    super.key,
  });

  final InventoriesLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayList = state.filteredInventories;

    if (displayList.isEmpty) {
      return Center(child: Text(l10n.invList_noItemsFilterMessage));
    }

    final employeeMap = {for (final e in state.employees) e.id: e.name};
    final roomMap = {for (final r in state.rooms) r.id: r.name};

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final item = displayList[index];
        final employeeName = employeeMap[item.employeeId] ?? l10n.invList_notSpecifiedMale;
        final roomName = roomMap[item.roomId] ?? l10n.invList_notSpecified;

        return InventoryListItem(
          inventory: item,
          employeeName: employeeName,
          roomName: roomName,
        );
      },
    );
  }
}
