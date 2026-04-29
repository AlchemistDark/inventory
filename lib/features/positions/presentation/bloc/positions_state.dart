import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';

/// Base class for all position states
abstract class PositionsState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const PositionsState();
}

/// Initial state for positions
class PositionsInitial extends PositionsState {
  /// Creates a [PositionsInitial] state
  const PositionsInitial();
}

/// State indicating that positions are being loaded
class PositionsLoading extends PositionsState {
  /// Creates a [PositionsLoading] state
  const PositionsLoading();
}

/// State indicating that positions have been loaded successfully
class PositionsLoaded extends PositionsState {
  /// List of loaded positions
  final List<PositionEntity> positions;

  @override
  List<Object?> get props => [positions];

  /// Creates a [PositionsLoaded] state
  const PositionsLoaded(this.positions);
}

/// State indicating an error occurred while working with positions
class PositionsError extends PositionsState {
  /// The failure type
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  /// Creates a [PositionsError] state
  const PositionsError(this.failure);
}
