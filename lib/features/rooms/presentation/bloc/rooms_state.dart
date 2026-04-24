import 'package:equatable/equatable.dart';
import '../../domain/entities/room_entity.dart';

abstract class RoomsState extends Equatable {
  @override
  List<Object?> get props => [];

  const RoomsState();
}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final List<RoomEntity> rooms;

  @override
  List<Object?> get props => [rooms];

  const RoomsLoaded(this.rooms);
}

class RoomsError extends RoomsState {
  final String message;

  @override
  List<Object?> get props => [message];

  const RoomsError(this.message);
}
