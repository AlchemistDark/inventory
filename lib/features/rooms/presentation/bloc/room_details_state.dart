import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Base class for all room details states
abstract class RoomDetailsState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const RoomDetailsState();
}

/// Initial state for room details
class RoomDetailsInitial extends RoomDetailsState {
  /// Creates a [RoomDetailsInitial] state
  const RoomDetailsInitial();
}

/// State indicating that room details are being loaded
class RoomDetailsLoading extends RoomDetailsState {
  /// Creates a [RoomDetailsLoading] state
  const RoomDetailsLoading();
}

/// State indicating that room details have been loaded successfully
class RoomDetailsLoaded extends RoomDetailsState {
  /// List of inventory items in the room
  final List<InventoryEntity> inventory;

  /// List of employees assigned to the room
  final List<EmployeeEntity> employees;

  @override
  List<Object?> get props => [inventory, employees];

  /// Creates a [RoomDetailsLoaded] state
  const RoomDetailsLoaded({
    required this.inventory,
    required this.employees,
  });
}

/// State indicating an error occurred while loading room details
class RoomDetailsError extends RoomDetailsState {
  /// The failure type
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  /// Creates a [RoomDetailsError] state
  const RoomDetailsError(this.failure);
}
