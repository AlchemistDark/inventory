import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A tab view displaying the list of inventory items located in a specific room.
class RoomInventoryTab extends StatelessWidget {
  /// Creates a [RoomInventoryTab].
  const RoomInventoryTab({required this.inventory, super.key});

  /// The list of inventory items to display.
  final List<InventoryEntity> inventory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (inventory.isEmpty) {
      return Center(child: Text(l10n.rooms_noInventory));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        final item = inventory[index];

        return Card(
          child: ListTile(
            title: Text(item.name),
            subtitle: Text(
                '${l10n.common_inventoryNumberPrefix}${item.inventoryNumber}'),
            trailing: Text('x${item.quantity}'),
          ),
        );
      },
    );
  }
}
