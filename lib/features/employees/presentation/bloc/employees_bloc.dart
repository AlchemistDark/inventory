import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC responsible for managing the list of employees, searching, and filtering.
class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  /// Use case for fetching all employees.
  final GetEmployeesUseCase getEmployeesUseCase;

  /// Use case for fetching available positions.
  final GetPositionsUseCase getPositionsUseCase;

  /// Use case for fetching available rooms.
  final GetRoomsUseCase getRoomsUseCase;

  /// Use case for fetching inventory assigned to an employee.
  final GetInventoryByEmployeeIdUseCase getInventoryByEmployeeIdUseCase;

  /// Use case for creating an employee.
  final CreateEmployeeUseCase createEmployeeUseCase;

  /// Use case for updating an employee.
  final UpdateEmployeeUseCase updateEmployeeUseCase;

  /// Use case for deleting an employee.
  final DeleteEmployeeUseCase deleteEmployeeUseCase;

  /// Creates an [EmployeesBloc] with the required use cases.
  EmployeesBloc({
    required this.getEmployeesUseCase,
    required this.getPositionsUseCase,
    required this.getRoomsUseCase,
    required this.getInventoryByEmployeeIdUseCase,
    required this.createEmployeeUseCase,
    required this.updateEmployeeUseCase,
    required this.deleteEmployeeUseCase,
  }) : super(EmployeesInitial()) {
    on<LoadEmployeesEvent>(_onLoadEmployees);
    on<SearchEmployeesEvent>(_onSearchEmployees);
    on<FilterEmployeesByPositionEvent>(_onFilterByPosition);
    on<LoadEmployeeDetailsEvent>(_onLoadEmployeeDetails);
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
      final positions = await getPositionsUseCase();
      final rooms = await getRoomsUseCase();

      final positionModels = positions
          .map((e) => PositionModel(
                id: e.id,
                name: e.name,
                createdAt: e.createdAt,
              ))
          .toList();

      final roomModels = rooms
          .map((e) => RoomModel(
                id: e.id,
                name: e.name,
                description: e.description,
                createdAt: e.createdAt,
              ))
          .toList();

      emit(EmployeesLoaded(
        allEmployees: employees,
        filteredEmployees: employees,
        positions: positionModels,
        rooms: roomModels,
      ));
    } catch (e) {
      emit(const EmployeesError(AppFailure.database));
    }
  }

  void _onSearchEmployees(
    SearchEmployeesEvent event,
    Emitter<EmployeesState> emit,
  ) {
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      final filtered = _filterEmployees(
        currentState.allEmployees,
        event.query,
        currentState.positionFilter,
      );

      emit(currentState.copyWith(
        filteredEmployees: filtered,
        searchQuery: event.query,
      ));
    }
  }

  void _onFilterByPosition(
    FilterEmployeesByPositionEvent event,
    Emitter<EmployeesState> emit,
  ) {
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      final filtered = _filterEmployees(
        currentState.allEmployees,
        currentState.searchQuery,
        event.positionId,
      );

      emit(currentState.copyWith(
        filteredEmployees: filtered,
        positionFilter: event.positionId,
      ));
    }
  }

  Future<void> _onLoadEmployeeDetails(
    LoadEmployeeDetailsEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      emit(currentState.copyWith(isDetailsLoading: true));

      try {
        final inventory =
            await getInventoryByEmployeeIdUseCase(event.employeeId);
        emit(currentState.copyWith(
          selectedEmployeeInventory: inventory,
          isDetailsLoading: false,
        ));
      } catch (e) {
        emit(const EmployeesError(AppFailure.database));
      }
    }
  }

  List<EmployeeEntity> _filterEmployees(
    List<EmployeeEntity> employees,
    String query,
    int? positionId,
  ) {
    return employees.where((employee) {
      final matchesQuery =
          employee.name.toLowerCase().contains(query.toLowerCase());
      final matchesPosition =
          positionId == null || employee.positionId == positionId;

      return matchesQuery && matchesPosition;
    }).toList();
  }

  Future<void> _onCreateEmployee(
    CreateEmployeeEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    try {
      await createEmployeeUseCase(event.employee);
      add(LoadEmployeesEvent());
    } catch (e) {
      emit(const EmployeesError(AppFailure.database));
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
      emit(const EmployeesError(AppFailure.database));
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
      emit(const EmployeesError(AppFailure.database));
    }
  }
}
