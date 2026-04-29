import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for searching categories by name
class SearchCategoriesUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [SearchCategoriesUseCase]
  SearchCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call(String query) async {
    return await repository.searchCategories(query);
  }
}
