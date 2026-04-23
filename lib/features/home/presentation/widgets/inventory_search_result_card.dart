import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

class InventorySearchResultCard extends StatelessWidget {
  const InventorySearchResultCard({
    required this.inventory,
    required this.onTap,
    super.key,
  });

  final InventoryEntity inventory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                '${AppStrings.home.quantityPrefix}${inventory.quantity}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (inventory.inventoryNumber != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${AppStrings.home.inventoryNumberLabel} ${inventory.inventoryNumber}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
