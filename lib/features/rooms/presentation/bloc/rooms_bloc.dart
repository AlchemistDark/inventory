import 'package:flutter_bloc/flutter_bloc.dart';
import 'rooms_event.dart';
import 'rooms_state.dart';
import '../../domain/usecases/get_rooms_usecase.dart';
import '../../domain/repositories/room_repository.dart';
import '../../domain/entities/room_entity.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final GetRoomsUseCase getRoomsUseCase;
  final RoomRepository repository;

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
      emit(RoomsError(e.toString()));
    }
  }

  Future<void> _onCreateRoom(
    CreateRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.createRoom(event.room);
      add(LoadRoomsEvent());
    } catch (e) {
      emit(RoomsError(e.toString()));
    }
  }

  Future<void> _onUpdateRoom(
    UpdateRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.updateRoom(event.room);
      add(LoadRoomsEvent());
    } catch (e) {
      emit(RoomsError(e.toString()));
    }
  }

  Future<void> _onDeleteRoom(
    DeleteRoomEvent event,
    Emitter<RoomsState> emit,
  ) async {
    try {
      await repository.deleteRoom(event.id);
      add(LoadRoomsEvent());
    } catch (e) {
      emit(RoomsError(e.toString()));
    }
  }
}
