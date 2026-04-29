import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';

class GetRoomsUseCase {
  final RoomRepository repository;

  GetRoomsUseCase(this.repository);

  Future<List<RoomEntity>> call() async {
    return await repository.getRooms();
  }
}
