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
      // Перенести в модель. To Json
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

    if (model.categoryId != null) {
      await db.insert(
        'inventory_categories',
        {
          'inventoryId': id,
          'categoryId': model.categoryId,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
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

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.id = ?
    ''', [id]);

    if (maps.isEmpty) return null;
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<InventoryModel?> getInventoryByBarcode(String barcode) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.barcode = ? OR i.inventoryNumber = ?
    ''', [barcode, barcode]);

    if (maps.isEmpty) return null;
    return InventoryModel.fromMap(maps.first);
  }

  @override
  Future<List<InventoryModel>> searchInventoriesByName(String query) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT i.*, ic.categoryId 
      FROM inventory i 
      LEFT JOIN inventory_categories ic ON i.id = ic.inventoryId
      WHERE i.name LIKE ? OR i.barcode LIKE ? OR i.inventoryNumber LIKE ?
      ORDER BY i.name ASC
    ''', ['%$query%', '%$query%', '%$query%']);

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

    // Update category
    await db.delete('inventory_categories', where: 'inventoryId = ?', whereArgs: [model.id]);
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

    await db.delete(
      'inventory',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
