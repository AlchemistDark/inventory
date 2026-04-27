import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';

/// Repository interface for managing employee data in the domain layer.
abstract class EmployeeRepository {
  /// Retrieves all employees.
  Future<List<EmployeeEntity>> getEmployees();

  /// Retrieves a specific employee by their unique ID.
  Future<EmployeeEntity?> getEmployeeById(int id);

  /// Creates a new employee record.
  Future<EmployeeEntity> createEmployee(EmployeeEntity employee);

  /// Updates an existing employee record.
  Future<void> updateEmployee(EmployeeEntity employee);

  /// Deletes an employee record by ID.
  Future<void> deleteEmployee(int id);

  /// Searches for employees matching the given query string.
  Future<List<EmployeeEntity>> searchEmployees(String query);
}
