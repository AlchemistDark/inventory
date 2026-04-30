import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

/// Database helper class for managing SQLite database
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  /// Returns the database instance, creating it if necessary
  Future<Database> get database async {
    _database ??= await _initializeDatabase();

    return _database!;
  }

  /// Factory constructor returns singleton instance
  factory DatabaseHelper() {
    return _instance;
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

    return openDatabase(dbPath, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  /// Upgrades the database from one version to another
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Migration to support many-to-many for positions and categories
      await db.execute('''
        CREATE TABLE employee_positions (
          employeeId INTEGER NOT NULL,
          positionId INTEGER NOT NULL,
          PRIMARY KEY(employeeId, positionId),
          FOREIGN KEY(employeeId) REFERENCES employees(id) ON DELETE CASCADE,
          FOREIGN KEY(positionId) REFERENCES positions(id) ON DELETE CASCADE
        )
      ''');

      // Migrate existing positionId from employees to employee_positions
      await db.execute('''
        INSERT INTO employee_positions (employeeId, positionId)
        SELECT id, positionId FROM employees WHERE positionId IS NOT NULL
      ''');

      // Note: SQLite doesn't support DROP COLUMN easily. 
      // In a real production app we would recreate the table without positionId.
      // For this task, we'll keep the column but stop using it, or leave as is if recreation is too risky.
    }
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
        roomId INTEGER,
        createdAt INTEGER NOT NULL,
        FOREIGN KEY(roomId) REFERENCES rooms(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE employee_positions (
        employeeId INTEGER NOT NULL,
        positionId INTEGER NOT NULL,
        PRIMARY KEY(employeeId, positionId),
        FOREIGN KEY(employeeId) REFERENCES employees(id) ON DELETE CASCADE,
        FOREIGN KEY(positionId) REFERENCES positions(id) ON DELETE CASCADE
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
