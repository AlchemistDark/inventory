import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for retrieving all employee records.
class GetEmployeesUseCase {
  /// The repository used for employee data operations.
  final EmployeeRepository repository;

  /// Creates a [GetEmployeesUseCase] with the provided [repository].
  GetEmployeesUseCase(this.repository);

  /// Executes the use case to fetch a list of all [EmployeeEntity] records.
  Future<List<EmployeeEntity>> call() async {
    return await repository.getEmployees();
  }
}
