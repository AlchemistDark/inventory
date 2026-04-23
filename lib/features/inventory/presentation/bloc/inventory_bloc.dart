import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryBloc extends Bloc<CoreInventoryEvent, InventoryState>
    with InventoryCommonHandler<InventoryState> {
  final SearchInventoriesByNameUseCase searchByNameUseCase;
  final GetInventoriesUseCase getInventoriesUseCase;
  final CreateInventoryUseCase createInventoryUseCase;
  final UpdateInventoryUseCase updateInventoryUseCase;

  final EmployeesLocalDataSource employeesDataSource;
  final CategoriesLocalDataSource categoriesDataSource;
  final RoomsLocalDataSource roomsDataSource;

  InventoryBloc({
    required this.searchByNameUseCase,
    required this.getInventoriesUseCase,
    required this.createInventoryUseCase,
    required this.updateInventoryUseCase,
    required this.employeesDataSource,
    required this.categoriesDataSource,
    required this.roomsDataSource,
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
      final rooms = await roomsDataSource.getRooms();

      emit(InventoriesLoaded(
        inventories: inventories,
        employees: employees,
        categories: categories,
        rooms: rooms,
      ));
    } catch (e) {
      emit(InventoryError(e.toString()));
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
        emit(InventoriesLoaded(
          inventories: results,
          employees: currentState.employees,
          categories: currentState.categories,
          rooms: currentState.rooms,
          searchQuery: event.query,
          categoryFilter: currentState.categoryFilter,
        ));
      } catch (e) {
        emit(InventoryError(e.toString()));
      }
    } else {
      await _onLoadInventories(const LoadInventoriesEvent(), emit);
    }
  }

  Future<void> _onFilterByCategory(
    FilterInventoriesByCategoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    if (state is InventoriesLoaded) {
      final currentState = state as InventoriesLoaded;
      emit(InventoriesLoaded(
        inventories: currentState.inventories,
        employees: currentState.employees,
        categories: currentState.categories,
        rooms: currentState.rooms,
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
      emit(InventoryError(e.toString()));
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
      emit(InventoryError(e.toString()));
    }
  }
}

