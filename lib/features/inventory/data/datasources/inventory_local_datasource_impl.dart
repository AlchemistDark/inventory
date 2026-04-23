import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/features/inventory/data/datasources/inventory_local_datasource.dart';
import 'package:inventory_p_shalaev/features/inventory/data/models/inventory_model.dart';
import 'package:sqflite/sqflite.dart';

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  final DatabaseHelper _databaseHelper;

  InventoryLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<InventoryModel> createInventory(InventoryModel model) async {
    final db = await _databaseHelper.database;

    final id = await db.insert(
      'inventory',
      model.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (model.categoryId != null) {
      await db.insert('inventory_categories', {
        'inventoryId': id,
        'categoryId': model.categoryId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

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
      categoryId: model.categoryId,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<InventoryModel>> getInventories() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      ORDER BY i.name ASC
    ''');

    return List<InventoryModel>.from(
      maps.map((map) => InventoryModel.fromMap(map)),
    );
  }

  @override
  Future<InventoryModel?> getInventoryById(int id) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.id = ?
    ''',
      [id],
    );

    if (maps.isEmpty) {
      return null;
    }
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<InventoryModel?> getInventoryByBarcode(String barcode) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.barcode = ? OR i.inventoryNumber = ?
    ''',
      [barcode, barcode],
    );

    if (maps.isEmpty) {
      return null;
    }
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<List<InventoryModel>> searchInventoriesByName(String query) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.name LIKE ? OR i.barcode LIKE ? OR i.inventoryNumber LIKE ?
      ORDER BY i.name ASC
    ''',
      ['%$query%', '%$query%', '%$query%'],
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
      model.toDbMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );

    // Update category
    await db.delete(
      'inventory_categories',
      where: 'inventoryId = ?',
      whereArgs: [model.id],
    );
    if (model.categoryId != null) {
      await db.insert('inventory_categories', {
        'inventoryId': model.id,
        'categoryId': model.categoryId,
      });
    }
  }

  @override
  Future<void> deleteInventory(int id) async {
    final db = await _databaseHelper.database;

    await db.delete('inventory', where: 'id = ?', whereArgs: [id]);
  }
}
