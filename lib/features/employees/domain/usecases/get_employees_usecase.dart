import '../entities/employee_entity.dart';
import '../repositories/employee_repository.dart';

class GetEmployeesUseCase {
  final EmployeeRepository repository;

  GetEmployeesUseCase(this.repository);

  Future<List<EmployeeEntity>> call() async {
    return await repository.getEmployees();
  }
}
