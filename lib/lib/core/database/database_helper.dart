import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final Directory documentsDirectory =
    await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'inventory.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        createdAt INTEGER NOT NULL
      )
    ''');

    // Другие таблицы будут добавлены позже
    await db.execute('''
      CREATE TABLE positions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        createdAt INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE rooms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        createdAt INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        positionId INTEGER NOT NULL,
        roomId INTEGER,
        createdAt INTEGER NOT NULL,
        FOREIGN KEY(positionId) REFERENCES positions(id),
        FOREIGN KEY(roomId) REFERENCES rooms(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE inventory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcode TEXT,
        name TEXT NOT NULL,
        inventoryNumber TEXT,
        quantity INTEGER NOT NULL DEFAULT 1,
        description TEXT,
        dateAdded INTEGER NOT NULL,
        employeeId INTEGER,
        roomId INTEGER,
        createdAt INTEGER NOT NULL,
        FOREIGN KEY(employeeId) REFERENCES employees(id),
        FOREIGN KEY(roomId) REFERENCES rooms(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE inventory_categories (
        inventoryId INTEGER NOT NULL,
        categoryId INTEGER NOT NULL,
        PRIMARY KEY(inventoryId, categoryId),
        FOREIGN KEY(inventoryId) REFERENCES inventory(id) ON DELETE CASCADE,
        FOREIGN KEY(categoryId) REFERENCES categories(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}