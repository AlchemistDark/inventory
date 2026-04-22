import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<CategoryEntity> createCategory(String name);
  Future<List<CategoryEntity>> getCategories();
  Future<CategoryEntity?> getCategoryById(int id);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
  Future<List<CategoryEntity>> searchCategories(String query);
}
