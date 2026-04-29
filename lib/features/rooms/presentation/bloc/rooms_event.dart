import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';

/// Base class for all room events
abstract class RoomsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const RoomsEvent();
}

/// Event to load all rooms
class LoadRoomsEvent extends RoomsEvent {
  /// Creates a [LoadRoomsEvent]
  const LoadRoomsEvent();
}

/// Event to create a new room
class CreateRoomEvent extends RoomsEvent {
  /// The room to create
  final RoomEntity room;

  @override
  List<Object?> get props => [room];

  /// Creates a [CreateRoomEvent]
  const CreateRoomEvent(this.room);
}

/// Event to update an existing room
class UpdateRoomEvent extends RoomsEvent {
  /// The room to update
  final RoomEntity room;

  @override
  List<Object?> get props => [room];

  /// Creates an [UpdateRoomEvent]
  const UpdateRoomEvent(this.room);
}

/// Event to delete a room
class DeleteRoomEvent extends RoomsEvent {
  /// The ID of the room to delete
  final int id;

  @override
  List<Object?> get props => [id];

  /// Creates a [DeleteRoomEvent]
  const DeleteRoomEvent(this.id);
}
