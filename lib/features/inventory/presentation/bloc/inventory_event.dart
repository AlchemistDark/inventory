import 'package:equatable/equatable.dart';
import '../../domain/entities/inventory_entity.dart';

// Events
abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object?> get props => [];
}

class InitializeInventoriesEvent extends InventoryEvent {
  const InitializeInventoriesEvent();
}

class LoadInventoriesEvent extends InventoryEvent {
  const LoadInventoriesEvent();
}

class SearchInventoriesByNameEvent extends InventoryEvent {
  final String query;
  const SearchInventoriesByNameEvent(this.query);
  @override
  List<Object?> get props => [query];
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

// States
abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

class InventoriesLoaded extends InventoryState {
  final List<InventoryEntity> inventories;
  final String? searchQuery;
  final int? categoryFilter;

  const InventoriesLoaded({
    required this.inventories,
    this.searchQuery,
    this.categoryFilter,
  });

  @override
  List<Object?> get props => [inventories, searchQuery, categoryFilter];
}

class InventoryCreated extends InventoryState {
  final InventoryEntity inventory;
  const InventoryCreated(this.inventory);
  @override
  List<Object?> get props => [inventory];
}

class InventoryError extends InventoryState {
  final String message;
  const InventoryError(this.message);
  @override
  List<Object?> get props => [message];
}
