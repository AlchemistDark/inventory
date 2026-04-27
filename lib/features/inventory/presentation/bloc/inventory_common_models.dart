import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/core/core.dart';
export 'package:equatable/equatable.dart';

/// Base class for all inventory-related events across the application.
///
/// This shared base allows multiple BLoCs to react to common inventory events.
abstract class CoreInventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Creates a [CoreInventoryEvent].
  const CoreInventoryEvent();
}

/// A shared event for searching inventory items by name.
///
/// This event can be handled by any BLoC that needs to perform name-based filtering.
class SearchInventoriesByNameEvent extends CoreInventoryEvent {
  /// The search string entered by the user.
  final String query;

  @override
  List<Object?> get props => [query];

  /// Creates a [SearchInventoriesByNameEvent] with the given [query].
  const SearchInventoriesByNameEvent(this.query);
}

/// A mixin for BLoC states that carry an error failure.
///
/// Simplifies the handling of error states by providing a consistent [failure] property.
mixin ErrorStateMixin on Equatable {
  /// The failure information related to the error state.
  AppFailure get failure;

  @override
  List<Object?> get props => [failure];
}

/// A mixin for BLoC states that represent an ongoing loading process.
///
/// Provides a consistent way to identify loading states across the application.
mixin LoadingStateMixin on Equatable {
  @override
  List<Object?> get props => [];
}
