import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/widgets/inventory_selection_tile.dart';

/// A generic list builder for inventory selection items.
class InventorySelectionList<T> extends StatelessWidget {
  /// Creates an [InventorySelectionList].
  const InventorySelectionList({
    required this.items,
    required this.itemName,
    required this.itemId,
    required this.icon,
    required this.isSelected,
    required this.onItemTap,
    super.key,
  });

  /// The items to display in the list.
  final List<T> items;

  /// Function to extract the name from an item.
  final String Function(T) itemName;

  /// Function to extract the ID from an item.
  final int Function(T) itemId;

  /// The icon to show for each item.
  final IconData icon;

  /// Function to determine if an item ID is currently selected.
  final bool Function(int id) isSelected;

  /// Callback when an item is tapped.
  final void Function(int id, bool isCurrentlySelected) onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final id = itemId(item);
        final name = itemName(item);
        final selected = isSelected(id);

        return InventorySelectionTile(
          name: name,
          isSelected: selected,
          icon: icon,
          onTap: () => onItemTap(id, selected),
        );
      },
    );
  }
}
