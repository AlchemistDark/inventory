import 'package:inventory_p_shalaev/core/database/database_helper.dart';
import 'package:inventory_p_shalaev/features/categories/data/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

/// Abstract interface for category local data operations
abstract class CategoriesLocalDataSource {
  /// Creates a new category with the given name and optional description
  Future<CategoryModel> createCategory(String name, {String? description});

  /// Returns all categories sorted by name
  Future<List<CategoryModel>> getCategories();

  /// Returns a category by its ID, or null if not found
  Future<CategoryModel?> getCategoryById(int id);

  /// Updates a category
  Future<void> updateCategory(CategoryModel model);

  /// Deletes a category by its ID
  Future<void> deleteCategory(int id);

  /// Searches categories whose name contains the query string
  Future<List<CategoryModel>> searchCategories(String query);
}

/// SQLite implementation of [CategoriesLocalDataSource]
class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final DatabaseHelper _databaseHelper;

  /// Creates [CategoriesLocalDataSourceImpl] with a database helper
  CategoriesLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<CategoryModel> createCategory(String name, {String? description}) async {
    final db = await _databaseHelper.database;

    final id = await db.insert('categories', {
      'name': name,
      'description': description,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return CategoryModel(
      id: id,
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
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

    if (maps.isEmpty) {
      return null;
    }

    return CategoryModel.fromMap(maps.first);
  }

  @override
  Future<void> updateCategory(CategoryModel model) async {
    final db = await _databaseHelper.database;

    await db.update(
      'categories',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      await txn.delete(
        'inventory_categories',
        where: 'categoryId = ?',
        whereArgs: [id],
      );
      await txn.delete('categories', where: 'id = ?', whereArgs: [id]);
    });
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
