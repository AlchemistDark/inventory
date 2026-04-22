import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/repositories/inventory_repository.dart';

/// Use case for creating a new inventory item
class CreateInventoryUseCase {
  final InventoryRepository repository;

  CreateInventoryUseCase(this.repository);

  Future<InventoryEntity> call(InventoryEntity entity) async {
    return await repository.createInventory(entity);
  }
}
