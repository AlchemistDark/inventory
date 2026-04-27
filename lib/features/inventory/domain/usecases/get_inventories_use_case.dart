import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for getting all inventories
class GetInventoriesUseCase {
  final InventoryRepository repository;

  GetInventoriesUseCase(this.repository);

  Future<List<InventoryEntity>> call() async {
    return await repository.getInventories();
  }
}
