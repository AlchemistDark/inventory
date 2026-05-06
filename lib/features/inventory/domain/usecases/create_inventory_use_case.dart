import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for creating a new inventory item
class CreateInventoryUseCase {
  final InventoryRepository repository;

  CreateInventoryUseCase(this.repository);

  Future<InventoryEntity> call(InventoryEntity entity, {int? defaultCategoryId}) async {
    final cleanedEntity = entity.copyWith(
      categoryIds: InventoryEntity.cleanCategoryIds(
        entity.categoryIds,
        defaultCategoryId,
      ),
    );

    return await repository.createInventory(cleanedEntity);
  }
}
