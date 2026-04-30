import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';

/// Abstract repository for category management
abstract class CategoriesRepository {
  /// Creates a new category with the given name
  Future<CategoryEntity> createCategory(String name);

  /// Returns all available categories
  Future<List<CategoryEntity>> getCategories();

  /// Returns a category by its unique ID
  Future<CategoryEntity?> getCategoryById(int id);

  /// Updates an existing category
  Future<void> updateCategory(CategoryEntity category);

  /// Deletes a category by its ID
  Future<void> deleteCategory(int id);

  /// Searches for categories matching the query string
  Future<List<CategoryEntity>> searchCategories(String query);
}
