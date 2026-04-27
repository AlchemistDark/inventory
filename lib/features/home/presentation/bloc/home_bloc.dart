import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing home screen state
///
/// Handles barcode search, name search, and initial data loading
class HomeBloc extends Bloc<CoreInventoryEvent, HomeState>
    with InventoryCommonHandler<HomeState> {
  /// Use case for searching inventory by barcode
  final SearchInventoryByBarcodeUseCase searchByBarcodeUseCase;

  /// Use case for searching inventories by name
  final SearchInventoriesByNameUseCase searchByNameUseCase;

  /// Use case for getting all inventories
  final GetInventoriesUseCase getInventoriesUseCase;

  /// Creates [HomeBloc] with required use cases
  HomeBloc({
    required this.searchByBarcodeUseCase,
    required this.searchByNameUseCase,
    required this.getInventoriesUseCase,
  }) : super(const HomeInitial()) {
    on<InitializeEvent>(_onInitialize);
    on<SearchInventoryByBarcodeEvent>(_onSearchByBarcode);
    on<SearchInventoriesByNameEvent>(_onSearchByName);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onInitialize(
    InitializeEvent event,
    Emitter<HomeState> emit,
  ) async {
    await executeWithLoading(
      emit: emit,
      action: () => getInventoriesUseCase(),
      onSuccess: (_) => const HomeInitial(),
      onError: (failure) => HomeError(failure),
      loadingState: const HomeLoading(),
    );
  }

  Future<void> _onSearchByBarcode(
    SearchInventoryByBarcodeEvent event,
    Emitter<HomeState> emit,
  ) async {
    await executeWithLoading(
      emit: emit,
      action: () => searchByBarcodeUseCase(event.barcode),
      onSuccess: (result) => result != null
          ? HomeSearchSuccess(result)
          : HomeNotFound(event.barcode),
      onError: (failure) => HomeError(failure),
      loadingState: const HomeLoading(),
    );
  }

  Future<void> _onSearchByName(
    SearchInventoriesByNameEvent event,
    Emitter<HomeState> emit,
  ) async {
    await performSearchByName(
      searchUseCase: searchByNameUseCase,
      query: event.query,
      emit: emit,
      onSuccess: (results) {
        if (results.isEmpty) {
          return HomeNotFound(event.query);
        } else if (results.length == 1) {
          return HomeSearchSuccess(results.first);
        } else {
          return HomeSearchMultipleResults(results);
        }
      },
      onError: (failure) => HomeError(failure),
      loadingState: const HomeLoading(),
    );
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(const HomeInitial());
  }
}
