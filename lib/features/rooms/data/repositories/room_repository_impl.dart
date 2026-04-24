import 'package:inventory_p_shalaev/features/rooms/domain/entities/room_entity.dart';
import 'package:inventory_p_shalaev/features/rooms/domain/repositories/room_repository.dart';
import 'package:inventory_p_shalaev/features/rooms/data/datasources/rooms_local_datasource.dart';
import 'package:inventory_p_shalaev/features/rooms/data/models/room_model.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomsLocalDataSource localDataSource;

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
