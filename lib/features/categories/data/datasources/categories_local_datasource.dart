import 'package:sqflite/sqflite.dart';
import '../models/category_model.dart';
import '../../../../core/database/database_helper.dart';

abstract class CategoriesLocalDataSource {
  Future<CategoryModel> createCategory(String name);
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel?> getCategoryById(int id);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);
  Future<List<CategoryModel>> searchCategories(String query);
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final DatabaseHelper _databaseHelper;

  CategoriesLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<CategoryModel> createCategory(String name) async {
    final db = await _databaseHelper.database;

    final id = await db.insert('categories', {
      'name': name,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return CategoryModel(id: id, name: name, createdAt: DateTime.now());
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      orderBy: 'name ASC',
    );

    return List<CategoryModel>.from(
      maps.map((map) => CategoryModel.fromMap(map)),
    );
  }

  @override
  Future<CategoryModel?> getCategoryById(int id) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return CategoryModel.fromMap(maps.first);
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    final db = await _databaseHelper.database;

    await db.update(
      'categories',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    final db = await _databaseHelper.database;

    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<CategoryModel>> searchCategories(String query) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );

    return List<CategoryModel>.from(
      maps.map((map) => CategoryModel.fromMap(map)),
    );
  }
}
