import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for updating an existing inventory item
class UpdateInventoryUseCase {
  final InventoryRepository repository;

  UpdateInventoryUseCase(this.repository);

  Future<void> call(InventoryEntity entity) async {
    return await repository.updateInventory(entity);
  }
}
