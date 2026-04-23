import 'package:inventory_p_shalaev/features/inventory/presentation/bloc/inventory_common_models.dart';

/// Base class for all home events
abstract class HomeEvent extends CoreInventoryEvent {
  const HomeEvent();
}

/// Event to initialize the home screen
class InitializeEvent extends HomeEvent {
  const InitializeEvent();
}

/// Event to search inventory by barcode
class SearchInventoryByBarcodeEvent extends HomeEvent {
  final String barcode;

  @override
  List<Object?> get props => [barcode];

  const SearchInventoryByBarcodeEvent(this.barcode);
}


/// Event to clear the search
class ClearSearchEvent extends HomeEvent {
  const ClearSearchEvent();
}
