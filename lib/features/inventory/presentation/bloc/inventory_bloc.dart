import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing inventory list state and operations.
///
/// This BLoC handles loading, searching, filtering, and performing CRUD
/// operations on inventory items. It interacts with multiple use cases
/// and data sources to provide a unified state for the inventory feature.
class InventoryBloc extends Bloc<CoreInventoryEvent, InventoryState>
    with InventoryCommonHandler<InventoryState> {
  /// Use case for searching inventories by name.
  final SearchInventoriesByNameUseCase searchByNameUseCase;

  /// Use case for getting all inventories.
  final GetInventoriesUseCase getInventoriesUseCase;

  /// Use case for creating a new inventory item.
  final CreateInventoryUseCase createInventoryUseCase;

  /// Use case for updating an existing inventory item.
  final UpdateInventoryUseCase updateInventoryUseCase;

  /// Use case for employee data, used to load responsible persons.
  final GetEmployeesUseCase getEmployeesUseCase;

  /// Use case for category data, used for classification and filtering.
  final GetCategoriesUseCase getCategoriesUseCase;

  /// Use case for room data, used to assign items to locations.
  final GetRoomsUseCase getRoomsUseCase;

  /// Creates [InventoryBloc] with required dependencies and sets the initial state.
  InventoryBloc({
    required this.searchByNameUseCase,
    required this.getInventoriesUseCase,
    required this.createInventoryUseCase,
    required this.updateInventoryUseCase,
    required this.getEmployeesUseCase,
    required this.getCategoriesUseCase,
    required this.getRoomsUseCase,
  }) : super(const InventoryInitial()) {
    on<InitializeInventoriesEvent>(_onInitialize);
    on<LoadInventoriesEvent>(_onLoadInventories);
    on<SearchInventoriesByNameEvent>(_onSearchByName);
    on<FilterInventoriesByCategoryEvent>(_onFilterByCategory);
    on<ClearFiltersEvent>(_onClearFilters);
    on<CreateInventoryEvent>(_onCreateInventory);
    on<UpdateInventoryEvent>(_onUpdateInventory);
  }

  Future<void> _onInitialize(
    InitializeInventoriesEvent event,
    Emitter<InventoryState> emit,
  ) async {
    await _onLoadInventories(const LoadInventoriesEvent(), emit);
  }

  Future<void> _onLoadInventories(
    LoadInventoriesEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      emit(const InventoryLoading());
      final inventories = await getInventoriesUseCase();
      final employees = await getEmployeesUseCase();
      final categories = await getCategoriesUseCase();
      final rooms = await getRoomsUseCase();

      emit(InventoriesLoaded(
        inventories: inventories,
        filteredInventories: inventories,
        employees: employees,
        categories: categories,
        rooms: rooms,
        employeeMap: {for (final e in employees) e.id: e.name},
        categoryMap: {for (final c in categories) c.id: c.name},
        roomMap: {for (final r in rooms) r.id: r.name},
      ));
    } catch (e) {
      emit(const InventoryError(AppFailure.database));
    }
  }

  Future<void> _onSearchByName(
    SearchInventoriesByNameEvent event,
    Emitter<InventoryState> emit,
  ) async {
    final currentState = state;
    if (currentState is InventoriesLoaded) {
      emit(const InventoryLoading());
      try {
        final results = await searchByNameUseCase(event.query);

        final filtered =
            results.filterByCategory(currentState.categoryFilter);

        emit(currentState.copyWith(
          inventories: results,
          filteredInventories: filtered,
          searchQuery: event.query,
        ));
      } catch (e) {
        emit(const InventoryError(AppFailure.database));
      }
    } else {
      await _onLoadInventories(const LoadInventoriesEvent(), emit);
    }
  }

  void _onFilterByCategory(
    FilterInventoriesByCategoryEvent event,
    Emitter<InventoryState> emit,
  ) {
    if (state is InventoriesLoaded) {
      final currentState = state as InventoriesLoaded;

      final filtered =
          currentState.inventories.filterByCategory(event.categoryId);

      emit(currentState.copyWith(
        filteredInventories: filtered,
        categoryFilter: event.categoryId,
      ));
    }
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<InventoryState> emit,
  ) async {
    await _onLoadInventories(const LoadInventoriesEvent(), emit);
  }

  Future<void> _onCreateInventory(
    CreateInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await createInventoryUseCase(event.inventory);
      emit(InventoryCreated(event.inventory));
      await _onLoadInventories(const LoadInventoriesEvent(), emit);
    } catch (e) {
      emit(const InventoryError(AppFailure.database));
    }
  }

  Future<void> _onUpdateInventory(
    UpdateInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await updateInventoryUseCase(event.inventory);
      await _onLoadInventories(const LoadInventoriesEvent(), emit);
    } catch (e) {
      emit(const InventoryError(AppFailure.database));
    }
  }
}
