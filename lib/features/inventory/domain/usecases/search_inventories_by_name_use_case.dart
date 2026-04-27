import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for searching inventory by name
class SearchInventoriesByNameUseCase {
  final InventoryRepository repository;

  SearchInventoriesByNameUseCase(this.repository);

  Future<List<InventoryEntity>> call(String query) async {
    if (query.trim().isEmpty) {
      return await repository.getInventories();
    }
    
    return await repository.searchInventoriesByName(query.trim());
  }
}
