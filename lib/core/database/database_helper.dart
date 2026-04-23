import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

/// Database helper class for managing SQLite database
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  /// Factory constructor returns singleton instance
  factory DatabaseHelper() {
    return _instance;
  }

  /// Returns the database instance, creating it if necessary
  Future<Database> get database async {
    _database ??= await _initializeDatabase();

    return _database!;
  }

  DatabaseHelper._internal();

  /// Closes the database connection
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Initializes the database with the given path
  Future<Database> _initializeDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String dbPath = path.join(documentsDirectory.path, 'inventory.db');

    return openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  /// Creates all tables on database initialization
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        createdAt INTEGER NOT NULL
      )
    ''');

    // Other tables will be added later
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
}
