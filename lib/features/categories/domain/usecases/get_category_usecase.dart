import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';
import '../../../../core/exceptions/exceptions.dart';

class GetCategoryUseCase {
  final CategoriesRepository repository;

  GetCategoryUseCase(this.repository);

  Future<CategoryEntity> call(int id) async {
    final category = await repository.getCategoryById(id);
    if (category == null) {
      throw CategoryNotFoundException(id: id);
    }
    return category;
  }
}
