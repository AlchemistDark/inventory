import '../entities/inventory_entity.dart';

abstract class InventoryRepository {
  Future<InventoryEntity> createInventory(InventoryEntity entity);
  Future<List<InventoryEntity>> getInventories();
  Future<InventoryEntity?> getInventoryById(int id);
  Future<InventoryEntity?> getInventoryByBarcode(String barcode);
  Future<List<InventoryEntity>> searchInventoriesByName(String query);
  Future<void> updateInventory(InventoryEntity entity);
  Future<void> deleteInventory(int id);
}
