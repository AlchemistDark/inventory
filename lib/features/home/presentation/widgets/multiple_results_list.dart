import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

class MultipleResultsList extends StatelessWidget {
  final List<InventoryEntity> inventories;
  final Function(InventoryEntity) onInventoryTap;

  const MultipleResultsList({
    super.key,
    required this.inventories,
    required this.onInventoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.home.foundItemsTitle.replaceAll(
            '%d',
            inventories.length.toString(),
          ),
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
                  '${AppStrings.home.quantityPrefix}${inventory.quantity}',
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
