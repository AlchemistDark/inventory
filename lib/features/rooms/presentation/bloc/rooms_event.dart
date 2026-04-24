import 'package:equatable/equatable.dart';
import '../../domain/entities/room_entity.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoomsEvent extends RoomsEvent {}

class CreateRoomEvent extends RoomsEvent {
  final RoomEntity room;
  const CreateRoomEvent(this.room);

  @override
  List<Object?> get props => [room];
}

class UpdateRoomEvent extends RoomsEvent {
  final RoomEntity room;
  const UpdateRoomEvent(this.room);

  @override
  List<Object?> get props => [room];
}

class DeleteRoomEvent extends RoomsEvent {
  final int id;
  const DeleteRoomEvent(this.id);

  @override
  List<Object?> get props => [id];
}
