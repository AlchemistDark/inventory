import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A widget that displays a list of categories.
class CategoryList extends StatelessWidget {
  /// Creates a [CategoryList].
  const CategoryList({
    required this.categories,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  /// The list of categories to display.
  final List<CategoryEntity> categories;

  /// Callback triggered when a category is deleted.
  final ValueChanged<CategoryEntity> onDelete;

  /// Callback triggered when a category is tapped (for editing).
  final ValueChanged<CategoryEntity> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return CategoryListTile(
          category: category,
          onDelete: () => onDelete(category),
          onTap: () => onTap(category),
        );
      },
    );
  }
}
