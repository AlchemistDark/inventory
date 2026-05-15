import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A scrollable list of inventory items.
///
/// Uses [ListView.builder] to efficiently render the items.
/// Responsible for mapping employee and room IDs to their respective names
/// using pre-computed maps for O(1) lookups.
class InventoryListView extends StatelessWidget {
  /// Creates an [InventoryListView].
  const InventoryListView({
    required this.items,
    super.key,
  });

  /// The list of inventory items to display.
  final List<InventoryEntity> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (items.isEmpty) {
      return Center(child: Text(l10n.invList_noItemsFilterMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InventoryListItem(
          inventory: items[index],
        );
      },
    );
  }
}
