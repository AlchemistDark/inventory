import 'package:inventory_p_shalaev/features/categories/domain/repositories/categories_repository.dart';

/// Use case for deleting an existing category
class DeleteCategoryUseCase {
  /// The repository used for category operations
  final CategoriesRepository repository;

  /// Creates a [DeleteCategoryUseCase]
  DeleteCategoryUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteCategory(id);
  }
}
