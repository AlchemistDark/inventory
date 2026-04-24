import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmployeesEvent extends EmployeesEvent {}

class CreateEmployeeEvent extends EmployeesEvent {
  final EmployeeEntity employee;
  const CreateEmployeeEvent(this.employee);

  @override
  List<Object?> get props => [employee];
}

class UpdateEmployeeEvent extends EmployeesEvent {
  final EmployeeEntity employee;
  const UpdateEmployeeEvent(this.employee);

  @override
  List<Object?> get props => [employee];
}

class DeleteEmployeeEvent extends EmployeesEvent {
  final int id;
  const DeleteEmployeeEvent(this.id);

  @override
  List<Object?> get props => [id];
}
