import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:sqflite/sqflite.dart';

/// Implementation of [InventoryLocalDataSource] using SQLite database.
///
/// Handles all local CRUD operations for inventory items, including
/// joining with category information and managing many-to-many/foreign keys.
class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  final DatabaseHelper _databaseHelper;

  /// Creates an [InventoryLocalDataSourceImpl] with the provided [DatabaseHelper].
  InventoryLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<InventoryModel> createInventory(InventoryModel model) async {
    final db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      final id = await txn.insert(
        'inventory',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (final categoryId in model.categoryIds) {
        await txn.insert(
          'inventory_categories',
          {
            'inventoryId': id,
            'categoryId': categoryId,
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
        categoryIds: model.categoryIds,
        createdAt: model.createdAt,
      );
    });
  }

  @override
  Future<List<InventoryModel>> getInventories() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query('inventory', orderBy: 'name ASC');

    final items = <InventoryModel>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final categories = await db.query(
        'inventory_categories',
        where: 'inventoryId = ?',
        whereArgs: [id],
      );
      final categoryIds = categories.map((c) => c['categoryId'] as int).toList();
      items.add(InventoryModel.fromMap(map, categoryIds: categoryIds));
    }

    return items;
  }

  @override
  Future<InventoryModel?> getInventoryById(int id) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    final categories = await db.query(
      'inventory_categories',
      where: 'inventoryId = ?',
      whereArgs: [id],
    );
    final categoryIds = categories.map((c) => c['categoryId'] as int).toList();

    return InventoryModel.fromMap(maps.first, categoryIds: categoryIds);
  }

  @override
  Future<InventoryModel?> getInventoryByBarcode(String barcode) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'barcode = ? OR inventoryNumber = ?',
      whereArgs: [barcode, barcode],
    );

    if (maps.isEmpty) {
      return null;
    }

    final id = maps.first['id'] as int;
    final categories = await db.query(
      'inventory_categories',
      where: 'inventoryId = ?',
      whereArgs: [id],
    );
    final categoryIds = categories.map((c) => c['categoryId'] as int).toList();

    return InventoryModel.fromMap(maps.first, categoryIds: categoryIds);
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

    final items = <InventoryModel>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final categories = await db.query(
        'inventory_categories',
        where: 'inventoryId = ?',
        whereArgs: [id],
      );
      final categoryIds = categories.map((c) => c['categoryId'] as int).toList();
      items.add(InventoryModel.fromMap(map, categoryIds: categoryIds));
    }

    return items;
  }

  @override
  Future<List<InventoryModel>> getInventoryByEmployeeId(int employeeId) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'inventory',
      where: 'employeeId = ?',
      whereArgs: [employeeId],
      orderBy: 'name ASC',
    );

    final items = <InventoryModel>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final categories = await db.query(
        'inventory_categories',
        where: 'inventoryId = ?',
        whereArgs: [id],
      );
      final categoryIds = categories.map((c) => c['categoryId'] as int).toList();
      items.add(InventoryModel.fromMap(map, categoryIds: categoryIds));
    }

    return items;
  }

  @override
  Future<void> updateInventory(InventoryModel model) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      await txn.update(
        'inventory',
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );

      // Update category links
      await txn.delete(
        'inventory_categories',
        where: 'inventoryId = ?',
        whereArgs: [model.id],
      );
      
      for (final categoryId in model.categoryIds) {
        await txn.insert('inventory_categories', {
          'inventoryId': model.id,
          'categoryId': categoryId,
        });
      }
    });
  }

  @override
  Future<void> deleteInventory(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('inventory', where: 'id = ?', whereArgs: [id]);
    // Cascade delete handles inventory_categories
  }
}
