import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// List widget for displaying multiple inventory search results.
///
/// Used when a search query matches multiple inventory items.
class MultipleResultsList extends StatelessWidget {
  /// Creates a [MultipleResultsList].
  const MultipleResultsList({
    required this.inventories,
    required this.onInventoryTap,
    super.key,
  });

  /// The list of inventory entities to display.
  final List<InventoryEntity> inventories;

  /// Callback function triggered when an inventory item is tapped.
  final ValueChanged<InventoryEntity> onInventoryTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.home_foundItemsTitle(inventories.length),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...inventories.map(
          (inventory) => GestureDetector(
            onTap: () => onInventoryTap(inventory),
            child: Card(
              child: ListTile(
                title: Text(inventory.name),
                subtitle: Text(
                  '${l10n.home_quantityPrefix}${inventory.quantity}',
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
