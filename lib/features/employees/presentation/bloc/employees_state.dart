import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Base class for all employees BLoC states.
abstract class EmployeesState extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeesState();
}

/// Initial state of the employees list.
class EmployeesInitial extends EmployeesState {}

/// State indicating that employees are currently being loaded.
class EmployeesLoading extends EmployeesState {}

/// State containing the successfully loaded employees and filter information.
class EmployeesLoaded extends EmployeesState {
  /// Complete list of all employees.
  final List<EmployeeEntity> allEmployees;

  /// List of employees matching the current search and filter criteria.
  final List<EmployeeEntity> filteredEmployees;

  /// List of available positions for filtering.
  final List<PositionModel> positions;

  /// List of available rooms.
  final List<RoomModel> rooms;

  /// Inventory assigned to the currently selected employee.
  final List<InventoryEntity> selectedEmployeeInventory;

  /// Current search query string.
  final String searchQuery;

  /// Currently active position filter ID.
  final int? positionFilter;

  /// Whether employee details (inventory) are currently loading.
  final bool isDetailsLoading;

  @override
  List<Object?> get props => [
        allEmployees,
        filteredEmployees,
        positions,
        rooms,
        selectedEmployeeInventory,
        searchQuery,
        positionFilter,
        isDetailsLoading,
      ];

  /// Creates an [EmployeesLoaded] state.
  const EmployeesLoaded({
    required this.allEmployees,
    required this.filteredEmployees,
    required this.positions,
    this.rooms = const [],
    this.selectedEmployeeInventory = const [],
    this.searchQuery = '',
    this.positionFilter,
    this.isDetailsLoading = false,
  });

  /// Creates a copy of the state with the specified properties updated.
  EmployeesLoaded copyWith({
    List<EmployeeEntity>? allEmployees,
    List<EmployeeEntity>? filteredEmployees,
    List<PositionModel>? positions,
    List<RoomModel>? rooms,
    List<InventoryEntity>? selectedEmployeeInventory,
    String? searchQuery,
    int? positionFilter,
    bool? isDetailsLoading,
  }) {
    return EmployeesLoaded(
      allEmployees: allEmployees ?? this.allEmployees,
      filteredEmployees: filteredEmployees ?? this.filteredEmployees,
      positions: positions ?? this.positions,
      rooms: rooms ?? this.rooms,
      selectedEmployeeInventory:
          selectedEmployeeInventory ?? this.selectedEmployeeInventory,
      searchQuery: searchQuery ?? this.searchQuery,
      positionFilter: positionFilter ?? this.positionFilter,
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
    );
  }
}

/// State indicating an error occurred while managing employees.
class EmployeesError extends EmployeesState {
  /// The failure details.
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  const EmployeesError(this.failure);
}
