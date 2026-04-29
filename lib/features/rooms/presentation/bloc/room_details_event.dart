import 'package:equatable/equatable.dart';

/// Base class for all room details events
abstract class RoomDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const RoomDetailsEvent();
}

/// Event to load details for a specific room
class LoadRoomDetailsEvent extends RoomDetailsEvent {
  /// The ID of the room to load details for
  final int roomId;

  @override
  List<Object?> get props => [roomId];

  /// Creates a [LoadRoomDetailsEvent]
  const LoadRoomDetailsEvent(this.roomId);
}
