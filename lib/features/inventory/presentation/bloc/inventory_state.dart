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

  /// List of available employees for selection.
  final List<EmployeeModel> employees;

  /// The current active search query, if any.
  final String? searchQuery;

  /// A lookup map for employees by their ID.
  final Map<int, String> employeeMap;


  @override
  List<Object?> get props => [
        inventories,
        employees,
        searchQuery,
        employeeMap,
      ];

  /// Creates an [InventoriesLoaded] state with all required data.
  InventoriesLoaded({
    required this.inventories,
    required this.employees,
    this.searchQuery,
  })  : employeeMap = {for (final e in employees) e.id: e.name};
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
