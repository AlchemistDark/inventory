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

  /// Data source for employee data, used to load responsible persons.
  final EmployeesLocalDataSource employeesDataSource;

  /// Data source for category data, used for classification and filtering.
  final CategoriesLocalDataSource categoriesDataSource;

  /// Creates [InventoryBloc] with required dependencies and sets the initial state.
  InventoryBloc({
    required this.searchByNameUseCase,
    required this.getInventoriesUseCase,
    required this.createInventoryUseCase,
    required this.updateInventoryUseCase,
    required this.employeesDataSource,
    required this.categoriesDataSource,
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
      final employees = await employeesDataSource.getEmployees();
      final categories = await categoriesDataSource.getCategories();

      emit(InventoriesLoaded(
        inventories: inventories,
        filteredInventories: inventories,
        employees: employees,
        categories: categories,
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

        var filtered = results;
        if (currentState.categoryFilter != null) {
          filtered = filtered
              .where((i) => i.categoryId == currentState.categoryFilter)
              .toList();
        }

        emit(InventoriesLoaded(
          inventories: results,
          filteredInventories: filtered,
          employees: currentState.employees,
          categories: currentState.categories,
          searchQuery: event.query,
          categoryFilter: currentState.categoryFilter,
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

      var filtered = currentState.inventories;
      filtered =
          filtered.where((i) => i.categoryId == event.categoryId).toList();

      emit(InventoriesLoaded(
        inventories: currentState.inventories,
        filteredInventories: filtered,
        employees: currentState.employees,
        categories: currentState.categories,
        searchQuery: currentState.searchQuery,
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
