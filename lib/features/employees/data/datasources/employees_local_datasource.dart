import '../models/employee_model.dart';
import 'package:inventory_p_shalaev/core/core.dart';

abstract class EmployeesLocalDataSource {
  Future<EmployeeModel> createEmployee(EmployeeModel model);
  Future<List<EmployeeModel>> getEmployees();
  Future<EmployeeModel?> getEmployeeById(int id);
  Future<List<EmployeeModel>> searchEmployees(String query);
  Future<void> updateEmployee(EmployeeModel model);
  Future<void> deleteEmployee(int id);
}

class EmployeesLocalDataSourceImpl implements EmployeesLocalDataSource {
  final DatabaseHelper _databaseHelper;

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
    await db.update('employees', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    final db = await _databaseHelper.database;
    await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}
