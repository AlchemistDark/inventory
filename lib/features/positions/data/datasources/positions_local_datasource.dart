import '../models/position_model.dart';
import '../../../../core/database/database_helper.dart';

abstract class PositionsLocalDataSource {
  Future<PositionModel> createPosition(PositionModel model);
  Future<List<PositionModel>> getPositions();
  Future<PositionModel?> getPositionById(int id);
  Future<List<PositionModel>> searchPositions(String query);
  Future<void> updatePosition(PositionModel model);
  Future<void> deletePosition(int id);
}

class PositionsLocalDataSourceImpl implements PositionsLocalDataSource {
  final DatabaseHelper _databaseHelper;

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
