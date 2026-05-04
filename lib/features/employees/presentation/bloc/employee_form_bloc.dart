import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC responsible for managing the state of the employee creation and editing form.
class EmployeeFormBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  /// Use case for fetching available positions.
  final GetPositionsUseCase getPositionsUseCase;

  /// Use case for fetching available rooms.
  final GetRoomsUseCase getRoomsUseCase;

  /// Use case for creating a new employee.
  final CreateEmployeeUseCase createEmployeeUseCase;

  /// Use case for updating an existing employee.
  final UpdateEmployeeUseCase updateEmployeeUseCase;

  /// The ID of the employee currently being edited, or null if creating a new one.
  int? _editingId;

  /// The creation date of the employee currently being edited.
  DateTime? _createdAt;

  /// Creates an [EmployeeFormBloc] with the required use cases.
  EmployeeFormBloc({
    required this.getPositionsUseCase,
    required this.getRoomsUseCase,
    required this.createEmployeeUseCase,
    required this.updateEmployeeUseCase,
  }) : super(const EmployeeFormInitial()) {
    on<InitializeEmployeeForm>(_onInitialize);
    on<NameChanged>(_onNameChanged);
    on<PositionsChanged>(_onPositionsChanged);
    on<RoomChanged>(_onRoomChanged);
    on<SubmitEmployeeForm>(_onSubmit);
  }

  Future<void> _onInitialize(
    InitializeEmployeeForm event,
    Emitter<EmployeeFormState> emit,
  ) async {
    emit(const EmployeeFormLoading());
    try {
      final positions = await getPositionsUseCase();
      final rooms = await getRoomsUseCase();

      _editingId = event.employee?.id;
      _createdAt = event.employee?.createdAt;

      // Find default position (exact match or fallback to first)
      int? defaultPositionId =
          positions.getIdByName(event.l10n.common_administrator);
      if (defaultPositionId == null && positions.isNotEmpty) {
        defaultPositionId = positions.first.id;
      }

      // Find default room (exact match or fallback to first)
      int? defaultRoomId = rooms.getIdByName(event.l10n.common_notDefined);
      if (defaultRoomId == null && rooms.isNotEmpty) {
        defaultRoomId = rooms.first.id;
      }

      emit(EmployeeFormMetadataLoaded(
        positions: positions,
        rooms: rooms,
        name: event.employee?.name ?? '',
        selectedPositionIds: event.employee?.positionIds ?? (defaultPositionId != null ? [defaultPositionId] : []),
        selectedRoomId: event.employee?.roomId ?? defaultRoomId,
        isEditing: event.employee != null,
      ));
    } catch (e) {
      emit(const EmployeeFormError(AppFailure.database));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<EmployeeFormState> emit) {
    if (state is EmployeeFormMetadataLoaded) {
      final currentState = state as EmployeeFormMetadataLoaded;
      emit(currentState.copyWith(
        name: event.name,
        nameError: _validateName(event.name),
      ));
    }
  }

  void _onPositionsChanged(
      PositionsChanged event, Emitter<EmployeeFormState> emit) {
    if (state is EmployeeFormMetadataLoaded) {
      final currentState = state as EmployeeFormMetadataLoaded;
      emit(currentState.copyWith(selectedPositionIds: event.positionIds));
    }
  }

  void _onRoomChanged(RoomChanged event, Emitter<EmployeeFormState> emit) {
    if (state is EmployeeFormMetadataLoaded) {
      final currentState = state as EmployeeFormMetadataLoaded;
      emit(currentState.copyWith(selectedRoomId: event.roomId));
    }
  }

  Future<void> _onSubmit(
    SubmitEmployeeForm event,
    Emitter<EmployeeFormState> emit,
  ) async {
    if (state is EmployeeFormMetadataLoaded) {
      final currentState = state as EmployeeFormMetadataLoaded;

      final nameError = _validateName(currentState.name);
      if (nameError != null) {
        emit(currentState.copyWith(nameError: nameError));

        return;
      }

      if (currentState.selectedPositionIds.isEmpty) {
        emit(const EmployeeFormValidationFailed(
            EmployeeFormValidationError.positionRequired));

        return;
      }

      emit(const EmployeeFormLoading());

      try {
        final employee = EmployeeEntity(
          id: _editingId ?? 0,
          name: currentState.name.trim(),
          positionIds: currentState.selectedPositionIds,
          roomId: currentState.selectedRoomId,
          createdAt: _createdAt ?? DateTime.now(),
        );

        if (currentState.isEditing) {
          await updateEmployeeUseCase(employee);
        } else {
          await createEmployeeUseCase(employee);
        }
        emit(const EmployeeFormSuccess());
      } catch (e) {
        emit(const EmployeeFormError(AppFailure.database));
      }
    }
  }

  EmployeeNameValidationError? _validateName(String name) {
    if (name.trim().length < 3) {
      return EmployeeNameValidationError.tooShort;
    }

    if (name.trim().length > 50) {
      return EmployeeNameValidationError.tooLong;
    }

    return null;
  }
}
