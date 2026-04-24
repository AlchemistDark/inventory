import 'package:flutter_bloc/flutter_bloc.dart';
import 'employees_event.dart';
import 'employees_state.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../domain/usecases/create_employee_usecase.dart';
import '../../domain/usecases/update_employee_usecase.dart';
import '../../domain/usecases/delete_employee_usecase.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final GetEmployeesUseCase getEmployeesUseCase;
  final CreateEmployeeUseCase createEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;
  final DeleteEmployeeUseCase deleteEmployeeUseCase;

  EmployeesBloc({
    required this.getEmployeesUseCase,
    required this.createEmployeeUseCase,
    required this.updateEmployeeUseCase,
    required this.deleteEmployeeUseCase,
  }) : super(EmployeesInitial()) {
    on<LoadEmployeesEvent>(_onLoadEmployees);
    on<CreateEmployeeEvent>(_onCreateEmployee);
    on<UpdateEmployeeEvent>(_onUpdateEmployee);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
  }

  Future<void> _onLoadEmployees(
    LoadEmployeesEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoading());
    try {
      final employees = await getEmployeesUseCase();
      emit(EmployeesLoaded(employees));
    } catch (e) {
      emit(EmployeesError(e.toString()));
    }
  }

  Future<void> _onCreateEmployee(
    CreateEmployeeEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
      await createEmployeeUseCase(event.employee);
      add(LoadEmployeesEvent());
    } catch (e) {
      emit(EmployeesError(e.toString()));
    }
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployeeEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
      await updateEmployeeUseCase(event.employee);
      add(LoadEmployeesEvent());
    } catch (e) {
      emit(EmployeesError(e.toString()));
    }
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
      await deleteEmployeeUseCase(event.id);
      add(LoadEmployeesEvent());
    } catch (e) {
      emit(EmployeesError(e.toString()));
    }
  }
}
