import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class InventoryDetailsContent extends StatelessWidget {
  final InventoryEntity inventory;
  final String employeeName;
  final String roomName;
  final String categoryName;

  const InventoryDetailsContent({
    required this.inventory,
    required this.employeeName,
    required this.roomName,
    required this.categoryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailSection(
            label: AppStrings.inventoryList.detailNameLabel,
            value: inventory.name,
            isTitle: true,
          ),
          const Divider(),
          DetailRow(
            label: AppStrings.inventoryList.detailBarcodeLabel,
            value: inventory.barcode ?? AppStrings.inventoryList.notSpecifiedMale,
            icon: Icons.qr_code,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailInventoryNumberLabel,
            value: inventory.inventoryNumber ?? AppStrings.inventoryList.notSpecifiedMale,
            icon: Icons.tag,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailQuantityLabel,
            value: '${inventory.quantity}',
            icon: Icons.inventory_2,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailRoomLabel,
            value: roomName,
            icon: Icons.room,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailResponsibleLabel,
            value: employeeName,
            icon: Icons.person,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailCategoryLabel,
            value: categoryName,
            icon: Icons.category,
          ),
          DetailRow(
            label: AppStrings.inventoryList.detailDateLabel,
            value: inventory.dateAdded.toString().split(' ')[0],
            icon: Icons.calendar_today,
          ),
          if (inventory.description != null && inventory.description!.isNotEmpty)
            DetailRow(
              label: AppStrings.inventoryList.detailDescriptionLabel,
              value: inventory.description!,
              icon: Icons.description,
            ),
        ],
      ),
    );
  }
}
