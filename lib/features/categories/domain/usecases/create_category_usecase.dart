import 'package:inventory_p_shalaev/core/exceptions/exceptions.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for creating a new category with validation
class CreateCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [CreateCategoryUseCase]
  CreateCategoryUseCase(this.repository);

  Future<CategoryEntity> call(CategoryEntity category) async {
    // Validate category name
    if (category.name.isEmpty) {
      throw CategoryValidationException(
        message: 'Category name cannot be empty',
      );
    }

    if (category.name.length < 3) {
      throw CategoryValidationException(
        message: 'Category name must be at least 3 characters',
      );
    }

    return await repository.createCategory(
      category.name,
    );
  }
}
