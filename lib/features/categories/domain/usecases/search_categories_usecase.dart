import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class SearchCategoriesUseCase {
  final CategoriesRepository repository;

  SearchCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call(String query) async {
    if (query.isEmpty) {
      return await repository.getCategories();
    }
    return await repository.searchCategories(query);
  }
}
