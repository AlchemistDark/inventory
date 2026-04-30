import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';

/// Use case for updating an existing room
class UpdateRoomUseCase {
  /// The repository providing room data access
  final RoomRepository repository;

  /// Creates an [UpdateRoomUseCase]
  const UpdateRoomUseCase(this.repository);

  /// Executes the use case to update an existing room
  Future<void> call(RoomEntity room) {
    return repository.updateRoom(room);
  }
}
