import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';
import 'package:inventory_p_shalaev/features/positions/domain/repositories/position_repository.dart';

/// Use case for updating an existing position
class UpdatePositionUseCase {
  /// The repository providing position data access
  final PositionRepository repository;

  /// Creates an [UpdatePositionUseCase]
  const UpdatePositionUseCase(this.repository);

  /// Executes the use case to update an existing position
  Future<void> call(PositionEntity position) {
    return repository.updatePosition(position);
  }
}
