import 'package:inventory_p_shalaev/features/employees/domain/repositories/employee_repository.dart';

/// Use case for deleting an employee record by ID.
class DeleteEmployeeUseCase {
  /// The repository used for employee data operations.
  final EmployeeRepository repository;

  /// Creates a [DeleteEmployeeUseCase] with the provided [repository].
  DeleteEmployeeUseCase(this.repository);

  /// Executes the use case to delete the employee with the given [id].
  Future<void> call(int id) async {
    return await repository.deleteEmployee(id);
  }
}
