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
    var displayList = state.inventories;
    
    if (state.categoryFilter != null) {
      displayList = displayList.where((i) => i.categoryId == state.categoryFilter).toList();
    }

    if (displayList.isEmpty) {
      return Center(child: Text(l10n.invList_noItemsFilterMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final item = displayList[index];
        final employeeName = state.employees.where((e) => e.id == item.employeeId).firstOrNull?.name ?? l10n.invList_notSpecifiedMale;
        final roomName = state.rooms.where((r) => r.id == item.roomId).firstOrNull?.name ?? l10n.invList_notSpecified;
        
        return InventoryListItem(
          inventory: item,
          employeeName: employeeName,
          roomName: roomName,
        );
      },
    );
  }
}
