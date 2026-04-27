import 'package:inventory_p_shalaev/features/features.dart';

/// Implementation of [InventoryRepository] that uses [InventoryLocalDataSource].
///
/// Responsible for coordinating data transfer between the domain layer
/// and the data sources, including mapping between entities and models.
class InventoryRepositoryImpl implements InventoryRepository {
  /// The local data source for inventory data.
  final InventoryLocalDataSource localDataSource;

  /// Creates an [InventoryRepositoryImpl] with the provided [localDataSource].
  InventoryRepositoryImpl(this.localDataSource);

  @override
  Future<InventoryEntity> createInventory(InventoryEntity entity) async {
    final model = InventoryModel.fromEntity(entity);
    final created = await localDataSource.createInventory(model);

    return created.toEntity();
  }

  @override
  Future<List<InventoryEntity>> getInventories() async {
    final models = await localDataSource.getInventories();

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<InventoryEntity?> getInventoryById(int id) async {
    final model = await localDataSource.getInventoryById(id);

    return model?.toEntity();
  }

  @override
  Future<InventoryEntity?> getInventoryByBarcode(String barcode) async {
    final model = await localDataSource.getInventoryByBarcode(barcode);

    return model?.toEntity();
  }

  @override
  Future<List<InventoryEntity>> searchInventoriesByName(String query) async {
    final models = await localDataSource.searchInventoriesByName(query);

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<InventoryEntity>> getInventoryByEmployeeId(int employeeId) async {
    final models = await localDataSource.getInventoryByEmployeeId(employeeId);

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateInventory(InventoryEntity entity) async {
    final model = InventoryModel.fromEntity(entity);
    await localDataSource.updateInventory(model);
  }

  @override
  Future<void> deleteInventory(int id) async {
    await localDataSource.deleteInventory(id);
  }
}
