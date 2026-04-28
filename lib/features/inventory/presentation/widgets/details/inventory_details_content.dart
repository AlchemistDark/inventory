import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// The core content view for the inventory details page.
///
/// Orchestrates multiple [DetailRow] and [DetailSection] widgets to present
/// all fields of an [InventoryEntity], including resolved metadata names.
class InventoryDetailsContent extends StatelessWidget {
  /// Creates an [InventoryDetailsContent] with the given [inventory] and metadata names.
  const InventoryDetailsContent({
    required this.inventory,
    required this.employeeName,
    required this.categoryName,
    super.key,
  });

  /// The inventory entity whose details are being displayed.
  final InventoryEntity inventory;

  /// The name of the employee responsible for this item.
  final String employeeName;

  /// The category name of the item.
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary item name as a title section.
          DetailSection(
            label: l10n.invList_detailNameLabel,
            value: inventory.name,
            isTitle: true,
          ),
          const Divider(),
          // Secondary details displayed as rows with icons.
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
            value: ' ',
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
          // Description section is only shown if it contains text.
          if (inventory.description != null &&
              inventory.description!.isNotEmpty)
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
