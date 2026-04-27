import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/employees/data/models/employee_model.dart';

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
    final id = await db.insert('employees', model.toMap());

    return EmployeeModel(
      id: id,
      name: model.name,
      positionId: model.positionId,
      roomId: model.roomId,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final db = await _databaseHelper.database;
    final maps = await db.query('employees', orderBy: 'name ASC');

    return List<EmployeeModel>.from(maps.map((m) => EmployeeModel.fromMap(m)));
  }

  @override
  Future<EmployeeModel?> getEmployeeById(int id) async {
    final db = await _databaseHelper.database;
    final maps = await db.query('employees', where: 'id = ?', whereArgs: [id]);

    return maps.isEmpty ? null : EmployeeModel.fromMap(maps.first);
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

    return List<EmployeeModel>.from(maps.map((m) => EmployeeModel.fromMap(m)));
  }

  @override
  Future<void> updateEmployee(EmployeeModel model) async {
    final db = await _databaseHelper.database;
    await db.update('employees', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}
