import '../entities/inventory_entity.dart';

/// Repository interface for inventory data operations
abstract class InventoryRepository {
  /// Creates a new inventory item
  Future<InventoryEntity> createInventory(InventoryEntity entity);

  /// Retrieves all inventory items
  Future<List<InventoryEntity>> getInventories();

  /// Retrieves an inventory item by its ID
  Future<InventoryEntity?> getInventoryById(int id);

  /// Retrieves an inventory item by its barcode
  Future<InventoryEntity?> getInventoryByBarcode(String barcode);

  /// Searches inventory items by name query
  Future<List<InventoryEntity>> searchInventoriesByName(String query);

  /// Updates an existing inventory item
  Future<void> updateInventory(InventoryEntity entity);

  /// Deletes an inventory item by its ID
  Future<void> deleteInventory(int id);
}
