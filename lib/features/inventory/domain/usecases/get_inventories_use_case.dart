import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/repositories/inventory_repository.dart';

/// Use case for getting all inventories
class GetInventoriesUseCase {
  final InventoryRepository repository;

  GetInventoriesUseCase(this.repository);

  Future<List<InventoryEntity>> call() async {
    return await repository.getInventories();
  }
}
