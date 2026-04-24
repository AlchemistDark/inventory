import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';
import 'package:inventory_p_shalaev/features/employees/data/models/employee_model.dart';
import 'package:inventory_p_shalaev/features/categories/data/models/category_model.dart';
import 'package:inventory_p_shalaev/features/rooms/data/models/room_model.dart';

abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];

  const InventoryState();
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState with LoadingStateMixin {
  const InventoryLoading();
}

class InventoriesLoaded extends InventoryState {
  final List<InventoryEntity> inventories;
  final List<InventoryEntity> filteredInventories;
  final List<EmployeeModel> employees;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final String? searchQuery;
  final int? categoryFilter;

  @override
  List<Object?> get props => [
        inventories,
        filteredInventories,
        employees,
        categories,
        rooms,
        searchQuery,
        categoryFilter,
      ];

  const InventoriesLoaded({
    required this.inventories,
    required this.filteredInventories,
    required this.employees,
    required this.categories,
    required this.rooms,
    this.searchQuery,
    this.categoryFilter,
  });
}

class InventoryCreated extends InventoryState {
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  const InventoryCreated(this.inventory);
}

class InventoryError extends InventoryState with ErrorStateMixin {
  @override
  final String message;

  const InventoryError(this.message);
}

