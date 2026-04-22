import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing home screen state
class HomeBloc extends Bloc<CoreInventoryEvent, HomeState>
    with InventoryCommonHandler<HomeState> {
  final SearchInventoryByBarcodeUseCase searchByBarcodeUseCase;
  final SearchInventoriesByNameUseCase searchByNameUseCase;
  final GetInventoriesUseCase getInventoriesUseCase;

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
      onError: (msg) => HomeError(msg),
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
      onSuccess: (result) {
        if (result != null) {
          return HomeSearchSuccess(result);
        } else {
          return HomeNotFound(event.barcode);
        }
      },
      onError: (msg) => HomeError(msg),
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
      onError: (msg) => HomeError(msg),
      loadingState: const HomeLoading(),
    );
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeInitial());
  }
}

