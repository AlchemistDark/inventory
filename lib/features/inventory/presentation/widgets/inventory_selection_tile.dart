import 'package:flutter/material.dart';

/// A tile widget used within [InventorySelectionSheet].
class InventorySelectionTile extends StatelessWidget {
  /// Creates an [InventorySelectionTile].
  const InventorySelectionTile({
    required this.name,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    super.key,
  });

  /// The display name of the item.
  final String name;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Icon to display for the item.
  final IconData icon;

  /// Callback triggered when the tile is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.colorScheme.primary : null,
      ),
      title: Text(
        name,
        style: TextStyle(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: theme.colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
