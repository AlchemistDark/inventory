import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

class MultipleResultsList extends StatelessWidget {
  const MultipleResultsList({
    required this.inventories,
    required this.onInventoryTap,
    super.key,
  });

  final List<InventoryEntity> inventories;
  final void Function(InventoryEntity) onInventoryTap;

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
