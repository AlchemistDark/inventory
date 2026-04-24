import 'package:equatable/equatable.dart';
import '../../domain/entities/employee_entity.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object?> get props => [];
}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<EmployeeEntity> employees;
  const EmployeesLoaded(this.employees);

  @override
  List<Object?> get props => [employees];
}

class EmployeesError extends EmployeesState {
  final String message;
  const EmployeesError(this.message);

  @override
  List<Object?> get props => [message];
}
