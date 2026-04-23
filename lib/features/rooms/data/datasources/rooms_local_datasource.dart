import '../models/room_model.dart';
import '../../../../core/database/database_helper.dart';

abstract class RoomsLocalDataSource {
  Future<RoomModel> createRoom(RoomModel model);
  Future<List<RoomModel>> getRooms();
  Future<RoomModel?> getRoomById(int id);
  Future<List<RoomModel>> searchRooms(String query);
  Future<void> updateRoom(RoomModel model);
  Future<void> deleteRoom(int id);
}

class RoomsLocalDataSourceImpl implements RoomsLocalDataSource {
  final DatabaseHelper _databaseHelper;

  RoomsLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<RoomModel> createRoom(RoomModel model) async {
    final db = await _databaseHelper.database;
    final id = await db.insert('rooms', model.toMap());

    return RoomModel(
      id: id,
      name: model.name,
      description: model.description,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<RoomModel>> getRooms() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('rooms', orderBy: 'name ASC');

    return List<RoomModel>.from(maps.map((m) => RoomModel.fromMap(m)));
  }

  @override
  Future<RoomModel?> getRoomById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('rooms', where: 'id = ?', whereArgs: [id]);

    return maps.isEmpty ? null : RoomModel.fromMap(maps.first);
  }

  @override
  Future<List<RoomModel>> searchRooms(String query) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'rooms',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );
    
    return List<RoomModel>.from(maps.map((m) => RoomModel.fromMap(m)));
  }

  @override
  Future<void> updateRoom(RoomModel model) async {
    final db = await _databaseHelper.database;
    await db.update('rooms', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<void> deleteRoom(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('rooms', where: 'id = ?', whereArgs: [id]);
  }
}
