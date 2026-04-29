import 'package:inventory_p_shalaev/features/positions/data/models/position_model.dart';
import 'package:inventory_p_shalaev/core/database/database_helper.dart';

/// Abstract data source for local position operations.
abstract class PositionsLocalDataSource {
  /// Inserts a new position record into the database.
  Future<PositionModel> createPosition(PositionModel model);

  /// Retrieves all position records from the database.
  Future<List<PositionModel>> getPositions();

  /// Retrieves a specific position by its unique ID.
  Future<PositionModel?> getPositionById(int id);

  /// Searches for positions with names matching the query string.
  Future<List<PositionModel>> searchPositions(String query);

  /// Updates an existing position record in the database.
  Future<void> updatePosition(PositionModel model);

  /// Deletes a position record from the database by its ID.
  Future<void> deletePosition(int id);
}

/// Implementation of [PositionsLocalDataSource] using SQLite.
class PositionsLocalDataSourceImpl implements PositionsLocalDataSource {
  final DatabaseHelper _databaseHelper;

  /// Creates a [PositionsLocalDataSourceImpl] with the given [DatabaseHelper].
  PositionsLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<PositionModel> createPosition(PositionModel model) async {
    final db = await _databaseHelper.database;
    final id = await db.insert('positions', model.toMap());

    return PositionModel(
      id: id,
      name: model.name,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<PositionModel>> getPositions() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('positions', orderBy: 'name ASC');

    return List<PositionModel>.from(maps.map((m) => PositionModel.fromMap(m)));
  }

  @override
  Future<PositionModel?> getPositionById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('positions', where: 'id = ?', whereArgs: [id]);

    return maps.isEmpty ? null : PositionModel.fromMap(maps.first);
  }

  @override
  Future<List<PositionModel>> searchPositions(String query) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'positions',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );
    
    return List<PositionModel>.from(maps.map((m) => PositionModel.fromMap(m)));
  }

  @override
  Future<void> updatePosition(PositionModel model) async {
    final db = await _databaseHelper.database;
    await db.update('positions', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<void> deletePosition(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('positions', where: 'id = ?', whereArgs: [id]);
  }
}
