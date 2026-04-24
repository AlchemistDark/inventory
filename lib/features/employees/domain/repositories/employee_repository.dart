import '../entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeEntity>> getEmployees();
  Future<EmployeeEntity?> getEmployeeById(int id);
  Future<EmployeeEntity> createEmployee(EmployeeEntity employee);
  Future<void> updateEmployee(EmployeeEntity employee);
  Future<void> deleteEmployee(int id);
  Future<List<EmployeeEntity>> searchEmployees(String query);
}
