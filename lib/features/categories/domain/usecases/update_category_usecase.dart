import 'package:inventory_p_shalaev/core/exceptions/exceptions.dart';
import 'package:inventory_p_shalaev/features/categories/domain/repositories/categories_repository.dart';

/// Use case for updating an existing category's name
class UpdateCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates an [UpdateCategoryUseCase]
  UpdateCategoryUseCase(this.repository);

  Future<void> call(int id, String name) async {
    // Validation
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

    await repository.updateCategory(id, name);
  }
}
