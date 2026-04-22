import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/repositories/inventory_repository.dart';

/// Use case for updating an existing inventory item
class UpdateInventoryUseCase {
  final InventoryRepository repository;

  UpdateInventoryUseCase(this.repository);

  Future<void> call(InventoryEntity entity) async {
    return await repository.updateInventory(entity);
  }
}
