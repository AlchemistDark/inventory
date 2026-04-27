import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';

/// Base class for all employee-related events.
abstract class EmployeesEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeesEvent();
}

/// Event to load all employees from the repository.
class LoadEmployeesEvent extends EmployeesEvent {}

/// Event to search employees by name.
class SearchEmployeesEvent extends EmployeesEvent {
  /// The search query string.
  final String query;

  @override
  List<Object?> get props => [query];

  const SearchEmployeesEvent(this.query);
}

/// Event to filter employees by their position ID.
class FilterEmployeesByPositionEvent extends EmployeesEvent {
  /// The ID of the position to filter by, or null for no filter.
  final int? positionId;

  @override
  List<Object?> get props => [positionId];

  const FilterEmployeesByPositionEvent(this.positionId);
}

/// Event to create a new employee.
class CreateEmployeeEvent extends EmployeesEvent {
  /// The employee entity to create.
  final EmployeeEntity employee;

  @override
  List<Object?> get props => [employee];

  const CreateEmployeeEvent(this.employee);
}

/// Event to update an existing employee.
class UpdateEmployeeEvent extends EmployeesEvent {
  /// The employee entity with updated data.
  final EmployeeEntity employee;

  @override
  List<Object?> get props => [employee];

  const UpdateEmployeeEvent(this.employee);
}

/// Event to delete an employee.
class DeleteEmployeeEvent extends EmployeesEvent {
  /// The unique ID of the employee to delete.
  final int id;

  @override
  List<Object?> get props => [id];

  const DeleteEmployeeEvent(this.id);
}

/// Event to load details for a specific employee, including their inventory.
class LoadEmployeeDetailsEvent extends EmployeesEvent {
  /// The unique ID of the employee.
  final int employeeId;

  @override
  List<Object?> get props => [employeeId];

  const LoadEmployeeDetailsEvent(this.employeeId);
}
