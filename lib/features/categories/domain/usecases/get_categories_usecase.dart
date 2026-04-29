import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for retrieving all categories
class GetCategoriesUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [GetCategoriesUseCase]
  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() async {
    return await repository.getCategories();
  }
}
