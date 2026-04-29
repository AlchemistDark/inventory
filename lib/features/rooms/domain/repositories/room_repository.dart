import '../entities/room_entity.dart';

/// Abstract repository for managing rooms/facilities.
abstract class RoomRepository {
  /// Returns a list of all available rooms.
  Future<List<RoomEntity>> getRooms();

  /// Returns a room by its unique ID.
  Future<RoomEntity?> getRoomById(int id);

  /// Creates a new room record.
  Future<RoomEntity> createRoom(RoomEntity room);

  /// Updates an existing room record.
  Future<void> updateRoom(RoomEntity room);

  /// Deletes a room record by its unique ID.
  Future<void> deleteRoom(int id);

  /// Searches for rooms matching the query string.
  Future<List<RoomEntity>> searchRooms(String query);
}
