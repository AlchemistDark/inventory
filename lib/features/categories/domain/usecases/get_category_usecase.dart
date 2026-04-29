import 'package:inventory_p_shalaev/core/exceptions/exceptions.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for retrieving a single category by ID
class GetCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [GetCategoryUseCase]
  GetCategoryUseCase(this.repository);

  Future<CategoryEntity> call(int id) async {
    final category = await repository.getCategoryById(id);
    if (category == null) {
      throw CategoryNotFoundException(id: id);
    }

    return category;
  }
}
