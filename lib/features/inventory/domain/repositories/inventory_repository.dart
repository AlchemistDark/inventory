import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// Repository interface for inventory data operations.
///
/// Defines the domain-level contract for interacting with inventory data.
/// This abstraction allows the domain layer to remain independent of
/// specific data source implementations.
abstract class InventoryRepository {
  /// Creates a new inventory item.
  ///
  /// Returns the created [InventoryEntity].
  Future<InventoryEntity> createInventory(InventoryEntity entity);

  /// Retrieves all inventory items.
  ///
  /// Returns a list of all [InventoryEntity]s.
  Future<List<InventoryEntity>> getInventories();

  /// Retrieves an inventory item by its unique ID.
  ///
  /// Returns the [InventoryEntity] if found, otherwise null.
  Future<InventoryEntity?> getInventoryById(int id);

  /// Retrieves an inventory item by its barcode or inventory number.
  ///
  /// Returns the [InventoryEntity] if found, otherwise null.
  Future<InventoryEntity?> getInventoryByBarcode(String barcode);

  /// Searches inventory items by a query (name, barcode, or inventory number).
  ///
  /// Returns a list of [InventoryEntity]s matching the query.
  Future<List<InventoryEntity>> searchInventoriesByName(String query);

  /// Retrieves all inventory items assigned to a specific employee.
  ///
  /// Returns a list of [InventoryEntity]s linked to the given [employeeId].
  Future<List<InventoryEntity>> getInventoryByEmployeeId(int employeeId);

  /// Updates an existing inventory item.
  Future<void> updateInventory(InventoryEntity entity);

  /// Deletes an inventory item by its unique ID.
  Future<void> deleteInventory(int id);
}
