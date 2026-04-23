import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/usecases/search_inventories_by_name_use_case.dart';

/// Mixin providing common inventory-related actions for BLoCs.
/// This helps reduce duplication between HomeBloc and InventoryBloc.
mixin InventoryCommonHandler<S> {
  /// Common pattern for executing a use case and handling loading/error states.
  Future<void> executeWithLoading<T>({
    required Emitter<S> emit,
    required Future<T> Function() action,
    required S Function(T result) onSuccess,
    required S Function(String message) onError,
    required S loadingState,
  }) async {
    emit(loadingState);
    try {
      final result = await action();
      emit(onSuccess(result));
    } catch (e) {
      emit(onError(e.toString()));
    }
  }

  /// Specialized search by name logic that can be shared.
  Future<void> performSearchByName({
    required SearchInventoriesByNameUseCase searchUseCase,
    required String query,
    required Emitter<S> emit,
    required S Function(dynamic results) onSuccess,
    required S Function(String message) onError,
    required S loadingState,
  }) async {
    return executeWithLoading(
      emit: emit,
      action: () => searchUseCase(query),
      onSuccess: onSuccess,
      onError: onError,
      loadingState: loadingState,
    );
  }
}
