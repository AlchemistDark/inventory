import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// Card widget displaying summarized information for an inventory search result.
class InventorySearchResultCard extends StatelessWidget {
  /// Creates an [InventorySearchResultCard].
  const InventorySearchResultCard({
    required this.inventory,
    required this.onTap,
    super.key,
  });

  /// The inventory entity to display.
  final InventoryEntity inventory;

  /// Callback triggered when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                      inventory.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${l10n.home_quantityPrefix}${inventory.quantity}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                '${l10n.home_inventoryNumberLabel} ${inventory.inventoryNumber}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
