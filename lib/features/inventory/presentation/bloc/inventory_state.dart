import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState with LoadingStateMixin {
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

class InventoryError extends InventoryState with ErrorStateMixin {
  @override
  final String message;

  const InventoryError(this.message);
}

