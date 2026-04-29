import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';

/// Base class for all position events
abstract class PositionsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const PositionsEvent();
}

/// Event to load all positions
class LoadPositionsEvent extends PositionsEvent {
  /// Creates a [LoadPositionsEvent]
  const LoadPositionsEvent();
}

/// Event to create a new position
class CreatePositionEvent extends PositionsEvent {
  /// The position to create
  final PositionEntity position;

  @override
  List<Object?> get props => [position];

  /// Creates a [CreatePositionEvent]
  const CreatePositionEvent(this.position);
}

/// Event to update an existing position
class UpdatePositionEvent extends PositionsEvent {
  /// The position to update
  final PositionEntity position;

  @override
  List<Object?> get props => [position];

  /// Creates an [UpdatePositionEvent]
  const UpdatePositionEvent(this.position);
}

/// Event to delete a position
class DeletePositionEvent extends PositionsEvent {
  /// The ID of the position to delete
  final int id;

  @override
  List<Object?> get props => [id];

  /// Creates a [DeletePositionEvent]
  const DeletePositionEvent(this.id);
}
