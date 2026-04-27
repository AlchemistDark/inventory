import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';
import 'package:inventory_p_shalaev/features/employees/domain/repositories/employee_repository.dart';

/// Use case for updating an existing employee record.
class UpdateEmployeeUseCase {
  /// The repository used for employee data operations.
  final EmployeeRepository repository;

  /// Creates an [UpdateEmployeeUseCase] with the provided [repository].
  UpdateEmployeeUseCase(this.repository);

  /// Executes the use case to update the given [employee].
  Future<void> call(EmployeeEntity employee) async {
    return await repository.updateEmployee(employee);
  }
}
