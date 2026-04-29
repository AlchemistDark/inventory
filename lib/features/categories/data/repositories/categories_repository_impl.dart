import 'package:inventory_p_shalaev/features/features.dart';

/// Implementation of [CategoriesRepository] using a local data source
class CategoriesRepositoryImpl implements CategoriesRepository {
  /// The local data source for categories
  final CategoriesLocalDataSource localDataSource;

  /// Creates a [CategoriesRepositoryImpl]
  CategoriesRepositoryImpl(this.localDataSource);

  @override
  Future<CategoryEntity> createCategory(String name) async {
    final model = await localDataSource.createCategory(name);

    return model.toEntity();
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await localDataSource.getCategories();

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CategoryEntity?> getCategoryById(int id) async {
    final model = await localDataSource.getCategoryById(id);

    return model?.toEntity();
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    await localDataSource.updateCategory(id, name);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await localDataSource.deleteCategory(id);
  }

  @override
  Future<List<CategoryEntity>> searchCategories(String query) async {
    final models = await localDataSource.searchCategories(query);

    return models.map((model) => model.toEntity()).toList();
  }
}
