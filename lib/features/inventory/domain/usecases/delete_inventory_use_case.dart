import 'package:inventory_p_shalaev/features/inventory/domain/repositories/inventory_repository.dart';

/// Use case for deleting an inventory item by its unique ID.
class DeleteInventoryUseCase {
  /// The repository used for inventory data operations.
  final InventoryRepository repository;

  /// Creates a [DeleteInventoryUseCase] with the provided [repository].
  DeleteInventoryUseCase(this.repository);

  /// Executes the use case to delete an inventory item.
  Future<void> call(int id) async {
    await repository.deleteInventory(id);
  }
}
