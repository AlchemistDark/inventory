import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Base class for all states of the inventory form.
abstract class InventoryFormState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Creates an [InventoryFormState].
  const InventoryFormState();
}

/// Initial state of the inventory form.
class InventoryFormInitial extends InventoryFormState {
  /// Creates an [InventoryFormInitial] state.
  const InventoryFormInitial();
}

/// State representing that a form operation (loading metadata or submitting) is in progress.
class InventoryFormLoading extends InventoryFormState {
  /// Creates an [InventoryFormLoading] state.
  const InventoryFormLoading();
}

/// State containing all metadata needed to populate form dropdowns and selection fields.
class InventoryFormMetadataLoaded extends InventoryFormState {
  /// List of available employees.
  final List<EmployeeEntity> employees;

  /// List of available categories.
  final List<CategoryEntity> categories;

  /// List of available rooms.
  final List<RoomEntity> rooms;

  /// The ID of the default employee to be pre-selected (e.g., 'Administrator').
  final int? defaultEmployeeId;

  /// The ID of the default category to be pre-selected (e.g., 'Undefined').
  final int? defaultCategoryId;

  /// The ID of the default room to be pre-selected (e.g., 'Undefined').
  final int? defaultRoomId;

  @override
  List<Object?> get props => [
        employees,
        categories,
        rooms,
        defaultEmployeeId,
        defaultCategoryId,
        defaultRoomId,
      ];

  /// Creates an [InventoryFormMetadataLoaded] state with metadata and defaults.
  const InventoryFormMetadataLoaded({
    required this.employees,
    required this.categories,
    required this.rooms,
    this.defaultEmployeeId,
    this.defaultCategoryId,
    this.defaultRoomId,
  });
}

/// State representing a successful form submission.
class InventoryFormSuccess extends InventoryFormState {
  /// Creates an [InventoryFormSuccess] state.
  const InventoryFormSuccess();
}

/// State representing that an error occurred during form processing.
class InventoryFormError extends InventoryFormState {
  /// The failure information related to the error.
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  /// Creates an [InventoryFormError] state with the given [failure].
  const InventoryFormError(this.failure);
}
