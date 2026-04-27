import 'package:inventory_p_shalaev/features/inventory/data/models/inventory_model.dart';

/// Local data source interface for inventory data operations.
///
/// Defines the contract for all local storage interactions related to inventory,
/// including creation, retrieval, search, updates, and deletion.
abstract class InventoryLocalDataSource {
  /// Creates a new inventory item in local storage.
  ///
  /// Returns the created [InventoryModel] with its generated ID.
  Future<InventoryModel> createInventory(InventoryModel model);

  /// Retrieves all inventory items from local storage.
  ///
  /// Returns a list of all [InventoryModel]s sorted by name.
  Future<List<InventoryModel>> getInventories();

  /// Retrieves an inventory item by its unique ID from local storage.
  ///
  /// Returns the [InventoryModel] if found, otherwise null.
  Future<InventoryModel?> getInventoryById(int id);

  /// Retrieves an inventory item by its barcode or inventory number from local storage.
  ///
  /// Returns the [InventoryModel] if found, otherwise null.
  Future<InventoryModel?> getInventoryByBarcode(String barcode);

  /// Searches inventory items by a name, barcode, or inventory number query in local storage.
  ///
  /// Returns a list of [InventoryModel]s matching the query.
  Future<List<InventoryModel>> searchInventoriesByName(String query);

  /// Retrieves all inventory items assigned to a specific employee.
  ///
  /// Returns a list of [InventoryModel]s linked to the given [employeeId].
  Future<List<InventoryModel>> getInventoryByEmployeeId(int employeeId);

  /// Updates an existing inventory item in local storage.
  Future<void> updateInventory(InventoryModel model);

  /// Deletes an inventory item by its unique ID from local storage.
  Future<void> deleteInventory(int id);
}
