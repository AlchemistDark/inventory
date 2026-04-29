import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';

/// Abstract repository for category management
abstract class CategoriesRepository {
  /// Creates a new category with the given name
  Future<CategoryEntity> createCategory(String name);

  /// Returns all available categories
  Future<List<CategoryEntity>> getCategories();

  /// Returns a category by its unique ID
  Future<CategoryEntity?> getCategoryById(int id);

  /// Updates the name of a category
  Future<void> updateCategory(int id, String name);

  /// Deletes a category by its ID
  Future<void> deleteCategory(int id);

  /// Searches for categories matching the query string
  Future<List<CategoryEntity>> searchCategories(String query);
}
