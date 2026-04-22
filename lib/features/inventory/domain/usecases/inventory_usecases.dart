import '../entities/inventory_entity.dart';
import '../repositories/inventory_repository.dart';

/// Use case for searching inventory by barcode
class SearchInventoryByBarcodeUseCase {
  final InventoryRepository repository;

  SearchInventoryByBarcodeUseCase(this.repository);

  Future<InventoryEntity?> call(String barcode) async {
    if (barcode.trim().isEmpty) {
      return null;
    }
    return await repository.getInventoryByBarcode(barcode.trim());
  }
}

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

/// Use case for getting all inventories
class GetInventoriesUseCase {
  final InventoryRepository repository;

  GetInventoriesUseCase(this.repository);

  Future<List<InventoryEntity>> call() async {
    return await repository.getInventories();
  }
}

/// Use case for creating a new inventory item
class CreateInventoryUseCase {
  final InventoryRepository repository;

  CreateInventoryUseCase(this.repository);

  Future<InventoryEntity> call(InventoryEntity entity) async {
    return await repository.createInventory(entity);
  }
}

/// Use case for updating an existing inventory item
class UpdateInventoryUseCase {
  final InventoryRepository repository;

  UpdateInventoryUseCase(this.repository);

  Future<void> call(InventoryEntity entity) async {
    return await repository.updateInventory(entity);
  }
}
