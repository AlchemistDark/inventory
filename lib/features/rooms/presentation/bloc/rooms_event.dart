import 'package:equatable/equatable.dart';
import '../../domain/entities/room_entity.dart';

abstract class RoomsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const RoomsEvent();
}

class LoadRoomsEvent extends RoomsEvent {}

class CreateRoomEvent extends RoomsEvent {
  final RoomEntity room;

  @override
  List<Object?> get props => [room];

  const CreateRoomEvent(this.room);
}

class UpdateRoomEvent extends RoomsEvent {
  final RoomEntity room;

  @override
  List<Object?> get props => [room];

  const UpdateRoomEvent(this.room);
}

class DeleteRoomEvent extends RoomsEvent {
  final int id;

  @override
  List<Object?> get props => [id];

  const DeleteRoomEvent(this.id);
}
