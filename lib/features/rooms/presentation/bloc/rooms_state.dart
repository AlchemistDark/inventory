import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/core/core.dart';
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
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  const RoomsError(this.failure);
}
