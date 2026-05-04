import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Base class for all states of the inventory management feature.
abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Creates an [InventoryState].
  const InventoryState();
}

/// Initial state of the inventory feature.
class InventoryInitial extends InventoryState {
  /// Creates an [InventoryInitial] state.
  const InventoryInitial();
}

/// State representing that an inventory operation is in progress.
class InventoryLoading extends InventoryState with LoadingStateMixin {
  /// Creates an [InventoryLoading] state.
  const InventoryLoading();
}

/// State containing the successfully loaded inventory data and active filters.
class InventoriesLoaded extends InventoryState {
  /// The full list of all inventory items.
  final List<InventoryEntity> inventories;

  /// The list of inventory items after applying search and category filters.
  final List<InventoryEntity> filteredInventories;

  /// List of available employees for selection.
  final List<EmployeeEntity> employees;

  /// List of available categories for selection and filtering.
  final List<CategoryEntity> categories;

  /// List of available rooms for selection.
  final List<RoomEntity> rooms;

  /// The current active search query, if any.
  final String? searchQuery;

  /// The ID of the currently selected category filter, if any.
  final int? categoryFilter;

  /// A lookup map for employees by their ID.
  final Map<int, String> employeeMap;

  /// A lookup map for categories by their ID.
  final Map<int, String> categoryMap;

  /// A lookup map for rooms by their ID.
  final Map<int, String> roomMap;

  @override
  List<Object?> get props => [
        inventories,
        filteredInventories,
        employees,
        categories,
        rooms,
        searchQuery,
        categoryFilter,
        employeeMap,
        categoryMap,
        roomMap,
      ];

  /// Creates an [InventoriesLoaded] state with all required data.
  const InventoriesLoaded({
    required this.inventories,
    required this.filteredInventories,
    required this.employees,
    required this.categories,
    required this.rooms,
    required this.employeeMap,
    required this.categoryMap,
    required this.roomMap,
    this.searchQuery,
    this.categoryFilter,
  });

  /// Creates a copy of this state with the given fields replaced by the new values.
  InventoriesLoaded copyWith({
    List<InventoryEntity>? inventories,
    List<InventoryEntity>? filteredInventories,
    List<EmployeeEntity>? employees,
    List<CategoryEntity>? categories,
    List<RoomEntity>? rooms,
    Map<int, String>? employeeMap,
    Map<int, String>? categoryMap,
    Map<int, String>? roomMap,
    String? searchQuery,
    int? categoryFilter,
  }) {
    return InventoriesLoaded(
      inventories: inventories ?? this.inventories,
      filteredInventories: filteredInventories ?? this.filteredInventories,
      employees: employees ?? this.employees,
      categories: categories ?? this.categories,
      rooms: rooms ?? this.rooms,
      employeeMap: employeeMap ?? this.employeeMap,
      categoryMap: categoryMap ?? this.categoryMap,
      roomMap: roomMap ?? this.roomMap,
      searchQuery: searchQuery ?? this.searchQuery,
      categoryFilter: categoryFilter ?? this.categoryFilter,
    );
  }
}

/// State representing that a new inventory item has been successfully created.
class InventoryCreated extends InventoryState {
  /// The newly created inventory item.
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  /// Creates an [InventoryCreated] state.
  const InventoryCreated(this.inventory);
}

/// State representing that an error occurred during an inventory operation.
class InventoryError extends InventoryState with ErrorStateMixin {
  @override
  final AppFailure failure;

  /// Creates an [InventoryError] state with the given [failure].
  const InventoryError(this.failure);
}
