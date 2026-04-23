import 'package:inventory_p_shalaev/features/inventory/data/models/inventory_model.dart';

/// Local data source interface for inventory data operations
abstract class InventoryLocalDataSource {
  /// Creates a new inventory item in local storage
  Future<InventoryModel> createInventory(InventoryModel model);

  /// Retrieves all inventory items from local storage
  Future<List<InventoryModel>> getInventories();

  /// Retrieves an inventory item by its ID from local storage
  Future<InventoryModel?> getInventoryById(int id);

  /// Retrieves an inventory item by its barcode from local storage
  Future<InventoryModel?> getInventoryByBarcode(String barcode);

  /// Searches inventory items by name query in local storage
  Future<List<InventoryModel>> searchInventoriesByName(String query);

  /// Updates an existing inventory item in local storage
  Future<void> updateInventory(InventoryModel model);

  /// Deletes an inventory item by its ID from local storage
  Future<void> deleteInventory(int id);
}
