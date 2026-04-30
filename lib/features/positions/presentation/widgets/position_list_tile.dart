import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A single row in the position list.
class PositionListTile extends StatelessWidget {
  /// Creates a [PositionListTile].
  const PositionListTile({
    required this.position,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The position entity for this tile.
  final PositionEntity position;

  /// Callback for the delete action.
  final VoidCallback onDelete;

  /// Callback for the tap action.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(position.name),
      leading: const Icon(Icons.work),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
