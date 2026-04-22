import 'package:equatable/equatable.dart';

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