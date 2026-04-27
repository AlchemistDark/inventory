import 'package:inventory_p_shalaev/features/features.dart';

/// Use case for retrieving all inventory items assigned to a specific employee.
class GetInventoryByEmployeeIdUseCase {
  final InventoryRepository repository;

  GetInventoryByEmployeeIdUseCase(this.repository);

  Future<List<InventoryEntity>> call(int employeeId) async {

    return await repository.getInventoryByEmployeeId(employeeId);
  }
}
