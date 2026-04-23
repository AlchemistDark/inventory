import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';

/// Base class for all home states
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading state
class HomeLoading extends HomeState with LoadingStateMixin {
  const HomeLoading();
}

/// State when search was successful with single result
class HomeSearchSuccess extends HomeState {
  final InventoryEntity inventory;

  @override
  List<Object?> get props => [inventory];

  const HomeSearchSuccess(this.inventory);
}

/// State when search returned multiple results
class HomeSearchMultipleResults extends HomeState {
  final List<InventoryEntity> inventories;

  @override
  List<Object?> get props => [inventories];

  const HomeSearchMultipleResults(this.inventories);
}

/// State when item was not found
class HomeNotFound extends HomeState {
  final String query;

  @override
  List<Object?> get props => [query];

  const HomeNotFound(this.query);
}

/// State when an error occurred
class HomeError extends HomeState with ErrorStateMixin {
  @override
  final String message;

  const HomeError(this.message);
}

