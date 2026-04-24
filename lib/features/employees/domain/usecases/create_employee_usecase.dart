import '../entities/employee_entity.dart';
import '../repositories/employee_repository.dart';

class CreateEmployeeUseCase {
  final EmployeeRepository repository;

  CreateEmployeeUseCase(this.repository);

  Future<EmployeeEntity> call(EmployeeEntity employee) async {
    return await repository.createEmployee(employee);
  }
}
