import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';

/// Use case for deleting a room
class DeleteRoomUseCase {
  /// The repository providing room data access
  final RoomRepository repository;

  /// Creates a [DeleteRoomUseCase]
  const DeleteRoomUseCase(this.repository);

  /// Executes the use case to delete a room by its ID
  Future<void> call(int id) {
    return repository.deleteRoom(id);
  }
}
