import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/usecases/inventory_usecases.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing home screen state
class HomeBloc extends Bloc<HomeEvent, HomeState> {
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
    emit(const HomeLoading());
    try {
      await getInventoriesUseCase();
      emit(const HomeInitial());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchByBarcode(
    SearchInventoryByBarcodeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final result = await searchByBarcodeUseCase(event.barcode);
      if (result != null) {
        emit(HomeSearchSuccess(result));
      } else {
        emit(HomeNotFound(event.barcode));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchByName(
    SearchInventoriesByNameEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final results = await searchByNameUseCase(event.query);
      if (results.isEmpty) {
        emit(HomeNotFound(event.query));
      } else if (results.length == 1) {
        emit(HomeSearchSuccess(results.first));
      } else {
        emit(HomeSearchMultipleResults(results));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeInitial());
  }
}
