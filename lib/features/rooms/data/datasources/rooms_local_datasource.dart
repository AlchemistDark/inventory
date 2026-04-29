import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/rooms/data/models/room_model.dart';

/// Abstract data source for local room operations.
abstract class RoomsLocalDataSource {
  /// Inserts a new room record into the database.
  Future<RoomModel> createRoom(RoomModel model);

  /// Retrieves all room records from the database.
  Future<List<RoomModel>> getRooms();

  /// Retrieves a specific room by its unique ID.
  Future<RoomModel?> getRoomById(int id);

  /// Searches for rooms with names matching the query string.
  Future<List<RoomModel>> searchRooms(String query);

  /// Updates an existing room record in the database.
  Future<void> updateRoom(RoomModel model);

  /// Deletes a room record from the database by its ID.
  Future<void> deleteRoom(int id);
}

/// Implementation of [RoomsLocalDataSource] using SQLite.
class RoomsLocalDataSourceImpl implements RoomsLocalDataSource {
  final DatabaseHelper _databaseHelper;

  /// Creates a [RoomsLocalDataSourceImpl] with the given [DatabaseHelper].
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
