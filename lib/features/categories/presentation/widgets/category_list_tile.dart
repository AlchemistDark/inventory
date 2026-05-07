import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A single row in the category list.
class CategoryListTile extends StatelessWidget {
  /// Creates a [CategoryListTile].
  const CategoryListTile({
    required this.category,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The category entity for this tile.
  final CategoryEntity category;

  /// Callback for the delete action.
  final VoidCallback onDelete;

  /// Callback for the tap action.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.name),
      leading: const Icon(Icons.category),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
