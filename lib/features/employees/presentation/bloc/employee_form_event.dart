import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Base class for all employee form-related events.
abstract class EmployeeFormEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeeFormEvent();
}

/// Event to initialize the form with an optional existing employee.
class InitializeEmployeeForm extends EmployeeFormEvent {
  /// The employee to edit, or null for creating a new one.
  final EmployeeEntity? employee;

  /// Localization instance.
  final AppLocalizations l10n;

  @override
  List<Object?> get props => [employee, l10n];

  const InitializeEmployeeForm({required this.l10n, this.employee});
}

/// Event triggered when the employee name input changes.
class NameChanged extends EmployeeFormEvent {
  /// The new name value.
  final String name;

  @override
  List<Object?> get props => [name];

  const NameChanged(this.name);
}

/// Event triggered when the selected positions change.
class PositionsChanged extends EmployeeFormEvent {
  /// The newly selected position IDs.
  final List<int> positionIds;

  @override
  List<Object?> get props => [positionIds];

  const PositionsChanged(this.positionIds);
}

/// Event triggered when the selected room changes.
class RoomChanged extends EmployeeFormEvent {
  /// The newly selected room ID, or null for "Not defined".
  final int? roomId;

  @override
  List<Object?> get props => [roomId];

  const RoomChanged(this.roomId);
}

/// Event to submit the employee form.
class SubmitEmployeeForm extends EmployeeFormEvent {}
