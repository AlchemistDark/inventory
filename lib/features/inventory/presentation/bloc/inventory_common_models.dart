import 'package:equatable/equatable.dart';
export 'package:equatable/equatable.dart';

/// Base class for all inventory-related events across the app.
abstract class CoreInventoryEvent extends Equatable {
  const CoreInventoryEvent();

  @override
  List<Object?> get props => [];
}

/// A single, shared search event used by multiple BLoCs.
class SearchInventoriesByNameEvent extends CoreInventoryEvent {
  final String query;

  const SearchInventoriesByNameEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Mixin for states that contain an error message
mixin ErrorStateMixin on Equatable {
  String get message;
  
  @override
  List<Object?> get props => [message];
}

/// Mixin for states that represent a loading process
mixin LoadingStateMixin on Equatable {
  @override
  List<Object?> get props => [];
}
