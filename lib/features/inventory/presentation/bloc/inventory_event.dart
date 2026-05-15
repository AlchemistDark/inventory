import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// Base class for all events related to inventory management.
abstract class InventoryEvent extends CoreInventoryEvent {
  /// Creates an [InventoryEvent].
  const InventoryEvent();
}

/// Event to initialize inventory data (loading employees, categories, rooms, and items).
class InitializeInventoriesEvent extends InventoryEvent {
  /// Creates an [InitializeInventoriesEvent].
  const InitializeInventoriesEvent();
}

/// Event to load or refresh the list of all inventory items.
class LoadInventoriesEvent extends InventoryEvent {
  /// Creates a [LoadInventoriesEvent].
  const LoadInventoriesEvent();
}

/// Event to filter the inventory list by a specific category.
class FilterInventoriesByCategoryEvent extends InventoryEvent {
  /// The ID of the category to filter by. If null, filter is removed.
  final int? categoryId;

  @override
  List<Object?> get props => [categoryId];

  /// Creates a [FilterInventoriesByCategoryEvent].
  const FilterInventoriesByCategoryEvent(this.categoryId);
}

/// Event to clear all active filters and search queries.
class ClearFiltersEvent extends InventoryEvent {
  /// Creates a [ClearFiltersEvent].
  const ClearFiltersEvent();
}

/// Event to refresh only metadata (employees, categories, rooms) without resetting items or filters.
class RefreshInventoryMetadataEvent extends InventoryEvent {
  /// Creates a [RefreshInventoryMetadataEvent].
  const RefreshInventoryMetadataEvent();
}

/// Event to create a new inventory item.
class CreateInventoryEvent extends InventoryEvent {
  /// The entity containing the data for the new inventory item.
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  /// Creates a [CreateInventoryEvent].
  const CreateInventoryEvent(this.inventory);
}

/// Event to update an existing inventory item.
class UpdateInventoryEvent extends InventoryEvent {
  /// The entity containing the updated data.
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  /// Creates an [UpdateInventoryEvent].
  const UpdateInventoryEvent(this.inventory);
}

/// Event to delete an inventory item.
class DeleteInventoryEvent extends InventoryEvent {
  /// The ID of the inventory item to delete.
  final int id;

  @override
  List<Object?> get props => [id];

  /// Creates a [DeleteInventoryEvent].
  const DeleteInventoryEvent(this.id);
}
