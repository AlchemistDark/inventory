import '../repositories/categories_repository.dart';
import '../../../../core/exceptions/exceptions.dart';

class UpdateCategoryUseCase {
  final CategoriesRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<void> call(int id, String name) async {
    // Валидация
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
