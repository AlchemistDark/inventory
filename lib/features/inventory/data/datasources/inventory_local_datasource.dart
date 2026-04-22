import 'package:inventory_p_shalaev/features/inventory/data/models/inventory_model.dart';

abstract class InventoryLocalDataSource {
  Future<InventoryModel> createInventory(InventoryModel model);
  Future<List<InventoryModel>> getInventories();
  Future<InventoryModel?> getInventoryById(int id);
  Future<InventoryModel?> getInventoryByBarcode(String barcode);
  Future<List<InventoryModel>> searchInventoriesByName(String query);
  Future<void> updateInventory(InventoryModel model);
  Future<void> deleteInventory(int id);
}
