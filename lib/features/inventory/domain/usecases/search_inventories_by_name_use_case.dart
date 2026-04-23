import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/repositories/inventory_repository.dart';

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
