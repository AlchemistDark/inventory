import 'package:inventory_p_shalaev/features/features.dart';

/// Implementation of the [EmployeeRepository] interface.
///
/// Handles data mapping between [EmployeeEntity] and [EmployeeModel]
/// and coordinates data operations using [EmployeesLocalDataSource].
class EmployeeRepositoryImpl implements EmployeeRepository {
  /// The local data source for employee records.
  final EmployeesLocalDataSource localDataSource;

  /// Creates an [EmployeeRepositoryImpl] with the provided [localDataSource].
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
