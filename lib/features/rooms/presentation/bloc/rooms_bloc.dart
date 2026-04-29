import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the state and operations of the rooms list.
class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  /// Use case for retrieving rooms.
  final GetRoomsUseCase getRoomsUseCase;

  /// Repository for other room operations (create, update, delete).
  final RoomRepository repository;

  /// Creates a [RoomsBloc] with the required dependencies.
  RoomsBloc({
    required this.getRoomsUseCase,
    required this.repository,
  }) : super(RoomsInitial()) {
    on<LoadRoomsEvent>(_onLoadRooms);
    on<CreateRoomEvent>(_onCreateRoom);
    on<UpdateRoomEvent>(_onUpdateRoom);
    on<DeleteRoomEvent>(_onDeleteRoom);
  }

  Future<void> _onLoadRooms(
    LoadRoomsEvent event,
    Emitter<RoomsState> emit,
  ) async {
    emit(RoomsLoading());
    try {
      final rooms = await getRoomsUseCase();
      emit(RoomsLoaded(rooms));
    } catch (e) {
      emit(const RoomsError(AppFailure.database));
    }
  }

  Future<void> _onCreateRoom(
    CreateRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.createRoom(event.room);
      add(const LoadRoomsEvent());
    } catch (e) {
      emit(const RoomsError(AppFailure.database));
    }
  }

  Future<void> _onUpdateRoom(
    UpdateRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.updateRoom(event.room);
      add(const LoadRoomsEvent());
    } catch (e) {
      emit(const RoomsError(AppFailure.database));
    }
  }

  Future<void> _onDeleteRoom(
    DeleteRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.deleteRoom(event.id);
      add(const LoadRoomsEvent());
    } catch (e) {
      emit(const RoomsError(AppFailure.database));
    }
  }
}
