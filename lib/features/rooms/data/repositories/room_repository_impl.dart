import 'package:inventory_p_shalaev/features/features.dart';

/// Implementation of [RoomRepository] using a local data source.
class RoomRepositoryImpl implements RoomRepository {
  /// The local data source for rooms.
  final RoomsLocalDataSource localDataSource;

  /// Creates a [RoomRepositoryImpl].
  RoomRepositoryImpl(this.localDataSource);

  @override
  Future<RoomEntity> createRoom(RoomEntity room) async {
    final model = RoomModel.fromEntity(room);
    final createdModel = await localDataSource.createRoom(model);

    return createdModel.toEntity();
  }

  @override
  Future<void> deleteRoom(int id) async {
    await localDataSource.deleteRoom(id);
  }

  @override
  Future<RoomEntity?> getRoomById(int id) async {
    final model = await localDataSource.getRoomById(id);

    return model?.toEntity();
  }

  @override
  Future<List<RoomEntity>> getRooms() async {
    final models = await localDataSource.getRooms();

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<RoomEntity>> searchRooms(String query) async {
    final models = await localDataSource.searchRooms(query);

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateRoom(RoomEntity room) async {
    final model = RoomModel.fromEntity(room);
    await localDataSource.updateRoom(model);
  }
}
