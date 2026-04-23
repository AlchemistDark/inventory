import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryListItem extends StatelessWidget {
  final InventoryEntity inventory;
  final String employeeName;
  final String roomName;

  const InventoryListItem({
    required this.inventory,
    required this.employeeName,
    required this.roomName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String qtyText = inventory.quantity > 0 ? '(${inventory.quantity}) ' : '';
    final String invNumText = inventory.inventoryNumber != null 
        ? '${inventory.inventoryNumber} ' 
        : '${AppStrings.inventoryList.noInventoryNumber} ';
    
    final titleText = '$invNumText$qtyText${inventory.name}';
    final subtitleText = '${AppStrings.inventoryList.detailRoomLabel} $roomName, ${AppStrings.inventoryList.detailResponsibleLabel} $employeeName';

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => InventoryDetailsPage(inventory: inventory),
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
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
