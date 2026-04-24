import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeesState extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeesState();
}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<EmployeeEntity> employees;

  @override
  List<Object?> get props => [employees];

  const EmployeesLoaded(this.employees);
}

class EmployeesError extends EmployeesState {
  final String message;

  @override
  List<Object?> get props => [message];

  const EmployeesError(this.message);
}
