import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';

/// Use case for creating a new room
class CreateRoomUseCase {
  /// The repository providing room data access
  final RoomRepository repository;

  /// Creates a [CreateRoomUseCase]
  const CreateRoomUseCase(this.repository);

  /// Executes the use case to create a new room
  Future<void> call(RoomEntity room) {
    return repository.createRoom(room);
  }
}
