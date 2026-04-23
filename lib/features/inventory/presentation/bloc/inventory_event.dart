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

  @override
  List<Object?> get props => [categoryId];

  const FilterInventoriesByCategoryEvent(this.categoryId);
}

class ClearFiltersEvent extends InventoryEvent {
  const ClearFiltersEvent();
}

class CreateInventoryEvent extends InventoryEvent {
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  const CreateInventoryEvent(this.inventory);
}

class UpdateInventoryEvent extends InventoryEvent {
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  const UpdateInventoryEvent(this.inventory);
}

