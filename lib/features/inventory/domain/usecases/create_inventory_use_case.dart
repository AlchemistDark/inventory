import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for creating a new inventory item
class CreateInventoryUseCase {
  final InventoryRepository repository;

  CreateInventoryUseCase(this.repository);

  Future<InventoryEntity> call(InventoryEntity entity) async {
    return await repository.createInventory(entity);
  }
}
