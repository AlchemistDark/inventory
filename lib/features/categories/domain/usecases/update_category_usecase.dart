import 'package:inventory_p_shalaev/core/exceptions/exceptions.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for updating an existing category's name
class UpdateCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates an [UpdateCategoryUseCase]
  UpdateCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) async {
    // Validation
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

    await repository.updateCategory(category.id, category.name);
  }
}
