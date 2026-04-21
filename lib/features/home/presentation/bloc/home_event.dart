import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';

/// Base class for all home events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize the home screen
class InitializeEvent extends HomeEvent {
  const InitializeEvent();
}

/// Event to search inventory by barcode
class SearchInventoryByBarcodeEvent extends HomeEvent {
  final String barcode;

  const SearchInventoryByBarcodeEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

/// Event to search inventory by name
class SearchInventoriesByNameEvent extends HomeEvent {
  final String query;

  const SearchInventoriesByNameEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to clear the search
class ClearSearchEvent extends HomeEvent {
  const ClearSearchEvent();
}

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
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// State when search was successful with single result
class HomeSearchSuccess extends HomeState {
  final InventoryEntity inventory;

  const HomeSearchSuccess(this.inventory);

  @override
  List<Object?> get props => [inventory];
}

/// State when search returned multiple results
class HomeSearchMultipleResults extends HomeState {
  final List<InventoryEntity> inventories;

  const HomeSearchMultipleResults(this.inventories);

  @override
  List<Object?> get props => [inventories];
}

/// State when item was not found
class HomeNotFound extends HomeState {
  final String query;

  const HomeNotFound(this.query);

  @override
  List<Object?> get props => [query];
}

/// State when an error occurred
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
