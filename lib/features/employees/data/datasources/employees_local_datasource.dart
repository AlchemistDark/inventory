import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/employees/data/models/employee_model.dart';
import 'package:sqflite/sqflite.dart';

/// Data source interface for managing local employee data.
abstract class EmployeesLocalDataSource {
  /// Creates a new employee record in the local database.
  Future<EmployeeModel> createEmployee(EmployeeModel model);

  /// Retrieves all employee records from the local database.
  Future<List<EmployeeModel>> getEmployees();

  /// Retrieves a specific employee by their unique identifier.
  Future<EmployeeModel?> getEmployeeById(int id);

  /// Searches for employees whose names match the given query.
  Future<List<EmployeeModel>> searchEmployees(String query);

  /// Updates an existing employee record in the local database.
  Future<void> updateEmployee(EmployeeModel model);

  /// Deletes an employee record from the local database by ID.
  Future<void> deleteEmployee(int id);
}

/// Implementation of [EmployeesLocalDataSource] using SQLite.
class EmployeesLocalDataSourceImpl implements EmployeesLocalDataSource {
  final DatabaseHelper _databaseHelper;

  /// Creates an [EmployeesLocalDataSourceImpl] with the provided [DatabaseHelper].
  EmployeesLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<EmployeeModel> createEmployee(EmployeeModel model) async {
    final db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      final id = await txn.insert(
        'employees',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (final positionId in model.positionIds) {
        await txn.insert(
          'employee_positions',
          {
            'employeeId': id,
            'positionId': positionId,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return EmployeeModel(
        id: id,
        name: model.name,
        positionIds: model.positionIds,
        roomId: model.roomId,
        createdAt: model.createdAt,
      );
    });
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('employees', orderBy: 'name ASC');

    final employees = <EmployeeModel>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final positions = await db.query(
        'employee_positions',
        where: 'employeeId = ?',
        whereArgs: [id],
      );
      final positionIds = positions.map((p) => p['positionId'] as int).toList();
      employees.add(EmployeeModel.fromMap(map, positionIds: positionIds));
    }

    return employees;
  }

  @override
  Future<EmployeeModel?> getEmployeeById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('employees', where: 'id = ?', whereArgs: [id]);

    if (maps.isEmpty) {
      return null;
    }

    final positions = await db.query(
      'employee_positions',
      where: 'employeeId = ?',
      whereArgs: [id],
    );
    final positionIds = positions.map((p) => p['positionId'] as int).toList();

    return EmployeeModel.fromMap(maps.first, positionIds: positionIds);
  }

  @override
  Future<List<EmployeeModel>> searchEmployees(String query) async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      'employees',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );

    final employees = <EmployeeModel>[];
    for (final map in maps) {
      final id = map['id'] as int;
      final positions = await db.query(
        'employee_positions',
        where: 'employeeId = ?',
        whereArgs: [id],
      );
      final positionIds = positions.map((p) => p['positionId'] as int).toList();
      employees.add(EmployeeModel.fromMap(map, positionIds: positionIds));
    }

    return employees;
  }

  @override
  Future<void> updateEmployee(EmployeeModel model) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // Exclude id from the update values to avoid issues with PK constraints
      final updateData = model.toMap()..remove('id');

      await txn.update(
        'employees',
        updateData,
        where: 'id = ?',
        whereArgs: [model.id],
      );

      // Update positions: delete existing and insert new ones
      await txn.delete(
        'employee_positions',
        where: 'employeeId = ?',
        whereArgs: [model.id],
      );

      for (final positionId in model.positionIds) {
        await txn.insert(
          'employee_positions',
          {
            'employeeId': model.id,
            'positionId': positionId,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<void> deleteEmployee(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('employees', where: 'id = ?', whereArgs: [id]);
    // Note: cascade delete handles employee_positions
  }
}
