import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class InventoryDetailsContent extends StatelessWidget {
  const InventoryDetailsContent({
    required this.inventory,
    required this.employeeName,
    required this.roomName,
    required this.categoryName,
    super.key,
  });

  final InventoryEntity inventory;
  final String employeeName;
  final String roomName;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailSection(
            label: l10n.invList_detailNameLabel,
            value: inventory.name,
            isTitle: true,
          ),
          const Divider(),
          DetailRow(
            label: l10n.invList_detailBarcodeLabel,
            value: inventory.barcode ?? l10n.invList_notSpecifiedMale,
            icon: Icons.qr_code,
          ),
          DetailRow(
            label: l10n.invList_detailInventoryNumberLabel,
            value: inventory.inventoryNumber ?? l10n.invList_notSpecifiedMale,
            icon: Icons.tag,
          ),
          DetailRow(
            label: l10n.invList_detailQuantityLabel,
            value: '${inventory.quantity}',
            icon: Icons.inventory_2,
          ),
          DetailRow(
            label: l10n.invList_detailRoomLabel,
            value: roomName,
            icon: Icons.room,
          ),
          DetailRow(
            label: l10n.invList_detailResponsibleLabel,
            value: employeeName,
            icon: Icons.person,
          ),
          DetailRow(
            label: l10n.invList_detailCategoryLabel,
            value: categoryName,
            icon: Icons.category,
          ),
          DetailRow(
            label: l10n.invList_detailDateLabel,
            value: inventory.dateAdded.toString().split(' ').first,
            icon: Icons.calendar_today,
          ),
          if (inventory.description != null && inventory.description!.isNotEmpty)
            DetailRow(
              label: l10n.invList_detailDescriptionLabel,
              value: inventory.description!,
              icon: Icons.description,
            ),
        ],
      ),
    );
  }
}
