import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A card-style widget representing a single inventory item in a list.
///
/// Displays basic information including the inventory number, name, quantity,
/// responsible employee, and room. Tapping the item navigates to the
/// [InventoryDetailsPage].
class InventoryListItem extends StatelessWidget {
  /// Creates an [InventoryListItem].
  const InventoryListItem({
    required this.inventory,
    required this.employeeName,
    required this.roomName,
    super.key,
  });

  /// The inventory entity data to display.
  final InventoryEntity inventory;

  /// The pre-resolved name of the responsible employee.
  final String employeeName;

  /// The pre-resolved name of the room where the item is located.
  final String roomName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Format title and quantity string.
    final qtyText = inventory.quantity > 0
        ? l10n.invList_itemQuantity(inventory.quantity)
        : '';
    final invNumText = '${inventory.inventoryNumber} ';

    final titleText = '$invNumText$qtyText${inventory.name}';
    final subtitleText =
        '${l10n.invList_detailRoomLabel} $roomName, ${l10n.invList_detailResponsibleLabel} $employeeName';

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) =>
                InventoryDetailsPage(inventoryId: inventory.id),
          ),
        );
      },
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
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitleText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
