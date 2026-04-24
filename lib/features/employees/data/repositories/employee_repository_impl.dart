import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';
import 'package:inventory_p_shalaev/features/employees/domain/repositories/employee_repository.dart';
import 'package:inventory_p_shalaev/features/employees/data/datasources/employees_local_datasource.dart';
import 'package:inventory_p_shalaev/features/employees/data/models/employee_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeesLocalDataSource localDataSource;

  EmployeeRepositoryImpl(this.localDataSource);

  @override
  Future<EmployeeEntity> createEmployee(EmployeeEntity employee) async {
    final model = EmployeeModel.fromEntity(employee);
    final createdModel = await localDataSource.createEmployee(model);

    return createdModel.toEntity();
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await localDataSource.deleteEmployee(id);
  }

  @override
  Future<EmployeeEntity?> getEmployeeById(int id) async {
    final model = await localDataSource.getEmployeeById(id);

    return model?.toEntity();
  }

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    final models = await localDataSource.getEmployees();

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<EmployeeEntity>> searchEmployees(String query) async {
    final models = await localDataSource.searchEmployees(query);

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateEmployee(EmployeeEntity employee) async {
    final model = EmployeeModel.fromEntity(employee);
    await localDataSource.updateEmployee(model);
  }
}
