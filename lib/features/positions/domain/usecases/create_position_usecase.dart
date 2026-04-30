import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';
import 'package:inventory_p_shalaev/features/positions/domain/repositories/position_repository.dart';

/// Use case for creating a new position
class CreatePositionUseCase {
  /// The repository providing position data access
  final PositionRepository repository;

  /// Creates a [CreatePositionUseCase]
  const CreatePositionUseCase(this.repository);

  /// Executes the use case to create a new position
  Future<void> call(PositionEntity position) {
    return repository.createPosition(position);
  }
}
