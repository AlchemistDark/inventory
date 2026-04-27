import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/usecases/search_inventories_by_name_use_case.dart';

/// A mixin providing common inventory-related logic for BLoCs.
///
/// This mixin helps reduce code duplication by centralizing shared actions
/// such as executing asynchronous tasks with loading and error handling.
mixin InventoryCommonHandler<S> {
  /// Executes a [action] with standard loading and error state management.
  ///
  /// 1. Emits [loadingState].
  /// 2. Executes the [action] future.
  /// 3. Emits state returned by [onSuccess] if the action succeeds.
  /// 4. Emits state returned by [onError] if an exception is caught.
  Future<void> executeWithLoading<T>({
    required Emitter<S> emit,
    required Future<T> Function() action,
    required S Function(T result) onSuccess,
    required S Function(AppFailure failure) onError,
    required S loadingState,
  }) async {
    emit(loadingState);
    try {
      final result = await action();
      emit(onSuccess(result));
    } catch (e) {
      emit(onError(AppFailure.database));
    }
  }

  /// Performs an inventory search by name with built-in state management.
  ///
  /// Uses [executeWithLoading] to handle the lifecycle of the search operation.
  Future<void> performSearchByName({
    required SearchInventoriesByNameUseCase searchUseCase,
    required String query,
    required Emitter<S> emit,
    required S Function(dynamic results) onSuccess,
    required S Function(AppFailure failure) onError,
    required S loadingState,
  }) {
    return executeWithLoading(
      emit: emit,
      action: () => searchUseCase(query),
      onSuccess: onSuccess,
      onError: onError,
      loadingState: loadingState,
    );
  }
}
