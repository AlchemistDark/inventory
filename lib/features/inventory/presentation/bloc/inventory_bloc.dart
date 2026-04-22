import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/inventory_usecases.dart';
import 'inventory_event.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final SearchInventoriesByNameUseCase searchByNameUseCase;
  final GetInventoriesUseCase getInventoriesUseCase;
  final CreateInventoryUseCase createInventoryUseCase;
  final UpdateInventoryUseCase updateInventoryUseCase;

  InventoryBloc({
    required this.searchByNameUseCase,
    required this.getInventoriesUseCase,
    required this.createInventoryUseCase,
    required this.updateInventoryUseCase,
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
    emit(const InventoryLoading());
    try {
      final inventories = await getInventoriesUseCase();
      emit(InventoriesLoaded(inventories: inventories));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> _onLoadInventories(
    LoadInventoriesEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(const InventoryLoading());
    try {
      final inventories = await getInventoriesUseCase();
      emit(InventoriesLoaded(inventories: inventories));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> _onSearchByName(
    SearchInventoriesByNameEvent event,
    Emitter<InventoryState> emit,
  ) async {
    emit(const InventoryLoading());
    try {
      final inventories = await searchByNameUseCase(event.query);
      emit(InventoriesLoaded(
        inventories: inventories,
        searchQuery: event.query,
      ));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> _onFilterByCategory(
    FilterInventoriesByCategoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    if (state is InventoriesLoaded) {
      final currentState = state as InventoriesLoaded;
      // Filter logic can be expanded
      emit(InventoriesLoaded(
        inventories: currentState.inventories,
        searchQuery: currentState.searchQuery,
        categoryFilter: event.categoryId,
      ));
    }
  }

  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      final inventories = await getInventoriesUseCase();
      emit(InventoriesLoaded(inventories: inventories));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> _onCreateInventory(
    CreateInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      final created = await createInventoryUseCase(event.inventory);
      emit(InventoryCreated(created));
      // Reload list
      final inventories = await getInventoriesUseCase();
      emit(InventoriesLoaded(inventories: inventories));
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
      // Reload list after update
      final inventories = await getInventoriesUseCase();
      emit(InventoriesLoaded(inventories: inventories));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }
}
