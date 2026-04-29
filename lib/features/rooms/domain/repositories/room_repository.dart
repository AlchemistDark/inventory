import '../entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRooms();
  Future<RoomEntity?> getRoomById(int id);
  Future<RoomEntity> createRoom(RoomEntity room);
  Future<void> updateRoom(RoomEntity room);
  Future<void> deleteRoom(int id);
  Future<List<RoomEntity>> searchRooms(String query);
}
