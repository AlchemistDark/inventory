import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';
import '../../../../core/exceptions/exceptions.dart';

class CreateCategoryUseCase {
  final CategoriesRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<CategoryEntity> call(String name) async {
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

    return await repository.createCategory(name);
  }
}
