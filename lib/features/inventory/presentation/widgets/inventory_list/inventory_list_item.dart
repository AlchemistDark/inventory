import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A card-style widget representing a single inventory item in a list.
///
/// Displays reactive information by watching metadata blocs for real-time
/// consistency. Tapping the item navigates to the [InventoryDetailsPage].
class InventoryListItem extends StatelessWidget {
  /// Creates an [InventoryListItem].
  const InventoryListItem({
    required this.inventory,
    super.key,
  });

  /// The inventory entity data to display.
  final InventoryEntity inventory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Watch source blocs for reactive metadata updates
    final employeesState = context.watch<EmployeesBloc>().state;
    final roomsState = context.watch<RoomsBloc>().state;

    final employeeName = employeesState is EmployeesLoaded
        ? employeesState.allEmployees
            .getNameById(inventory.employeeId, fallback: l10n.invList_notSpecifiedMale)
        : l10n.invList_notSpecifiedMale;

    final roomName = roomsState is RoomsLoaded
        ? roomsState.rooms
            .getNameById(inventory.roomId, fallback: l10n.invList_notSpecified)
        : l10n.invList_notSpecified;

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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitleText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
