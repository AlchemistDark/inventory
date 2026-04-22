import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

abstract class InventoryEvent extends CoreInventoryEvent {
  const InventoryEvent();
}

class InitializeInventoriesEvent extends InventoryEvent {
  const InitializeInventoriesEvent();
}

class LoadInventoriesEvent extends InventoryEvent {
  const LoadInventoriesEvent();
}


class FilterInventoriesByCategoryEvent extends InventoryEvent {
  final int categoryId;

  const FilterInventoriesByCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ClearFiltersEvent extends InventoryEvent {
  const ClearFiltersEvent();
}

class CreateInventoryEvent extends InventoryEvent {
  final InventoryEntity inventory;

  const CreateInventoryEvent(this.inventory);

  @override
  List<Object?> get props => [inventory];
}

class UpdateInventoryEvent extends InventoryEvent {
  final InventoryEntity inventory;

  const UpdateInventoryEvent(this.inventory);

  @override
  List<Object?> get props => [inventory];
}

