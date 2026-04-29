import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';

/// Use case for retrieving all available rooms.
class GetRoomsUseCase {
  /// The repository used for room operations.
  final RoomRepository repository;

  /// Creates a [GetRoomsUseCase].
  GetRoomsUseCase(this.repository);

  Future<List<RoomEntity>> call() async {
    return await repository.getRooms();
  }
}
