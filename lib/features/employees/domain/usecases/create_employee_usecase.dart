import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for creating a new employee record.
class CreateEmployeeUseCase {
  /// The repository used for employee data operations.
  final EmployeeRepository repository;

  /// Creates a [CreateEmployeeUseCase] with the provided [repository].
  CreateEmployeeUseCase(this.repository);

  /// Executes the use case to create a new [employee].
  Future<EmployeeEntity> call(EmployeeEntity employee) async {
    return await repository.createEmployee(employee);
  }
}
