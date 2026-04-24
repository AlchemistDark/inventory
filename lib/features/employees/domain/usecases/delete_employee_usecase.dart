import '../repositories/employee_repository.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;

  DeleteEmployeeUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteEmployee(id);
  }
}
