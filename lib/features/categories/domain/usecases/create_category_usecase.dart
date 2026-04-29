import 'package:inventory_p_shalaev/core/exceptions/exceptions.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for creating a new category with validation
class CreateCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [CreateCategoryUseCase]
  CreateCategoryUseCase(this.repository);

  Future<CategoryEntity> call(String name) async {
    // Validate category name
    if (name.isEmpty) {
      throw CategoryValidationException(
        message: 'Category name cannot be empty',
      );
    }

    if (name.length < 3) {
      throw CategoryValidationException(
        message: 'Category name must be at least 3 characters',
      );
    }

    if (name.length > 50) {
      throw CategoryValidationException(
        message: 'Category name cannot exceed 50 characters',
      );
    }

    return await repository.createCategory(name);
  }
}
