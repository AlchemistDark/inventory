import 'package:sqflite/sqflite.dart';
import '../models/inventory_model.dart';
import '../../../../core/database/database_helper.dart';

abstract class InventoryLocalDataSource {
  Future<InventoryModel> createInventory(InventoryModel model);
  Future<List<InventoryModel>> getInventories();
  Future<InventoryModel?> getInventoryById(int id);
  Future<InventoryModel?> getInventoryByBarcode(String barcode);
  Future<List<InventoryModel>> searchInventoriesByName(String query);
  Future<void> updateInventory(InventoryModel model);
  Future<void> deleteInventory(int id);
}

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  final DatabaseHelper _databaseHelper;

  InventoryLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<InventoryModel> createInventory(InventoryModel model) async {
    final db = await _databaseHelper.database;

    final id = await db.insert(
      'inventory',
      {
        'barcode': model.barcode,
        'name': model.name,
        'inventoryNumber': model.inventoryNumber,
        'quantity': model.quantity,
        'description': model.description,
        'dateAdded': model.dateAdded.millisecondsSinceEpoch,
        'employeeId': model.employeeId,
        'roomId': model.roomId,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return InventoryModel(
      id: id,
      barcode: model.barcode,
      name: model.name,
      inventoryNumber: model.inventoryNumber,
      quantity: model.quantity,
      description: model.description,
      dateAdded: model.dateAdded,
      employeeId: model.employeeId,
      roomId: model.roomId,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<InventoryModel>> getInventories() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      orderBy: 'name ASC',
    );

    return List<InventoryModel>.from(
      maps.map((map) => InventoryModel.fromMap(map)),
    );
  }

  @override
  Future<InventoryModel?> getInventoryById(int id) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<InventoryModel?> getInventoryByBarcode(String barcode) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'barcode = ? OR inventoryNumber = ?',
      whereArgs: [barcode, barcode],
    );

    if (maps.isEmpty) return null;
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<List<InventoryModel>> searchInventoriesByName(String query) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'name LIKE ? OR barcode LIKE ? OR inventoryNumber LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      orderBy: 'name ASC',
    );

    return List<InventoryModel>.from(
      maps.map((map) => InventoryModel.fromMap(map)),
    );
  }

  @override
  Future<void> updateInventory(InventoryModel model) async {
    final db = await _databaseHelper.database;

    await db.update(
      'inventory',
      {
        'name': model.name,
        'inventoryNumber': model.inventoryNumber,
        'quantity': model.quantity,
        'description': model.description,
        'employeeId': model.employeeId,
        'roomId': model.roomId,
      },
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> deleteInventory(int id) async {
    final db = await _databaseHelper.database;

    await db.delete(
      'inventory',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
