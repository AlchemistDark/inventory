import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';

/// Base class for all states of the [RoomsBloc].
abstract class RoomsState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Creates a [RoomsState].
  const RoomsState();
}

/// Initial state when the rooms list is first created.
class RoomsInitial extends RoomsState {}

/// State indicating that room data is currently being loaded.
class RoomsLoading extends RoomsState {}

/// State containing the successfully loaded list of rooms.
class RoomsLoaded extends RoomsState {
  /// The list of loaded room entities.
  final List<RoomEntity> rooms;

  @override
  List<Object?> get props => [rooms];

  /// Creates a [RoomsLoaded] state.
  const RoomsLoaded(this.rooms);
}

/// State indicating that an error occurred during a room operation.
class RoomsError extends RoomsState {
  /// The type of failure that occurred.
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  /// Creates a [RoomsError] state.
  const RoomsError(this.failure);
}
