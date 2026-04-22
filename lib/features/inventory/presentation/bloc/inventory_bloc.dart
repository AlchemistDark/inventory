import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryBloc extends Bloc<CoreInventoryEvent, InventoryState>
    with InventoryCommonHandler<InventoryState> {
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
    await executeWithLoading(
      emit: emit,
      action: () => getInventoriesUseCase(),
      onSuccess: (results) => InventoriesLoaded(inventories: results),
      onError: (msg) => InventoryError(msg),
      loadingState: const InventoryLoading(),
    );
  }

  Future<void> _onLoadInventories(
    LoadInventoriesEvent event,
    Emitter<InventoryState> emit,
  ) async {
    await executeWithLoading(
      emit: emit,
      action: () => getInventoriesUseCase(),
      onSuccess: (results) => InventoriesLoaded(inventories: results),
      onError: (msg) => InventoryError(msg),
      loadingState: const InventoryLoading(),
    );
  }

  Future<void> _onSearchByName(
    SearchInventoriesByNameEvent event,
    Emitter<InventoryState> emit,
  ) async {
    await performSearchByName(
      searchUseCase: searchByNameUseCase,
      query: event.query,
      emit: emit,
      onSuccess: (results) => InventoriesLoaded(
        inventories: results,
        searchQuery: event.query,
      ),
      onError: (msg) => InventoryError(msg),
      loadingState: const InventoryLoading(),
    );
  }

  Future<void> _onFilterByCategory(
    FilterInventoriesByCategoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    if (state is InventoriesLoaded) {
      final currentState = state as InventoriesLoaded;
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
    await _onLoadInventories(const LoadInventoriesEvent(), emit);
  }

  Future<void> _onCreateInventory(
    CreateInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await createInventoryUseCase(event.inventory);
      emit(InventoryCreated(event.inventory));
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

