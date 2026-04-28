import '../repositories/categories_repository.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteCategory(id);
  }
}
