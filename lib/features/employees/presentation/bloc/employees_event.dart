import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeesEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeesEvent();
}

class LoadEmployeesEvent extends EmployeesEvent {}

class CreateEmployeeEvent extends EmployeesEvent {
  final EmployeeEntity employee;

  @override
  List<Object?> get props => [employee];

  const CreateEmployeeEvent(this.employee);
}

class UpdateEmployeeEvent extends EmployeesEvent {
  final EmployeeEntity employee;

  @override
  List<Object?> get props => [employee];

  const UpdateEmployeeEvent(this.employee);
}

class DeleteEmployeeEvent extends EmployeesEvent {
  final int id;

  @override
  List<Object?> get props => [id];

  const DeleteEmployeeEvent(this.id);
}
