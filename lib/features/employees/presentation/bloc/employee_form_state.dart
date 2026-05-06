import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Enum representing specific validation errors for the employee name.
enum EmployeeNameValidationError {
  /// Name is shorter than the minimum required length (3 characters).
  tooShort,

  /// Name is longer than the maximum allowed length (50 characters).
  tooLong,
}

/// Enum representing general form validation errors.
enum EmployeeFormValidationError {
  /// A position selection is required.
  positionRequired,
}

/// Base class for all employee form BLoC states.
abstract class EmployeeFormState extends Equatable {
  @override
  List<Object?> get props => [];

  const EmployeeFormState();
}

/// Initial state of the employee form.
class EmployeeFormInitial extends EmployeeFormState {
  const EmployeeFormInitial();
}

/// State indicating that the form metadata or submission is currently loading.
class EmployeeFormLoading extends EmployeeFormState {
  const EmployeeFormLoading();
}

/// State containing all metadata (positions, rooms) and current field values.
class EmployeeFormMetadataLoaded extends EmployeeFormState {
  /// List of available positions for selection.
  final List<PositionEntity> positions;

  /// List of available rooms for selection.
  final List<RoomEntity> rooms;

  /// Current name input value.
  final String name;

  /// Currently selected position IDs.
  final List<int> selectedPositionIds;

  /// Currently selected room ID.
  final int? selectedRoomId;

  /// Whether the form is in editing mode (vs creation).
  final bool isEditing;

  /// Current validation error for the name field, if any.
  final EmployeeNameValidationError? nameError;

  @override
  List<Object?> get props => [
        positions,
        rooms,
        name,
        selectedPositionIds,
        selectedRoomId,
        isEditing,
        nameError,
      ];

  /// Creates an [EmployeeFormMetadataLoaded] state.
  const EmployeeFormMetadataLoaded({
    required this.positions,
    required this.rooms,
    this.name = '',
    this.selectedPositionIds = const [],
    this.selectedRoomId,
    this.isEditing = false,
    this.nameError,
  });

  /// Creates a copy of the state with specified properties updated.
  EmployeeFormMetadataLoaded copyWith({
    List<PositionEntity>? positions,
    List<RoomEntity>? rooms,
    String? name,
    List<int>? selectedPositionIds,
    int? Function()? selectedRoomId,
    bool? isEditing,
    EmployeeNameValidationError? nameError,
  }) {
    return EmployeeFormMetadataLoaded(
      positions: positions ?? this.positions,
      rooms: rooms ?? this.rooms,
      name: name ?? this.name,
      selectedPositionIds: selectedPositionIds ?? this.selectedPositionIds,
      selectedRoomId:
          selectedRoomId != null ? selectedRoomId() : this.selectedRoomId,
      isEditing: isEditing ?? this.isEditing,
      nameError: nameError,
    );
  }
}

/// State indicating successful form submission.
class EmployeeFormSuccess extends EmployeeFormState {
  const EmployeeFormSuccess();
}

/// State indicating an error occurred during form operations.
class EmployeeFormError extends EmployeeFormState {
  /// The failure details.
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  const EmployeeFormError(this.failure);
}

/// State indicating a specific validation error occurred during submission.
class EmployeeFormValidationFailed extends EmployeeFormState {
  /// The validation error type.
  final EmployeeFormValidationError error;

  @override
  List<Object?> get props => [error];

  const EmployeeFormValidationFailed(this.error);
}
