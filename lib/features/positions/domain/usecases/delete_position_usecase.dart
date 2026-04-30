import 'package:inventory_p_shalaev/features/positions/domain/repositories/position_repository.dart';

/// Use case for deleting a position
class DeletePositionUseCase {
  /// The repository providing position data access
  final PositionRepository repository;

  /// Creates a [DeletePositionUseCase]
  const DeletePositionUseCase(this.repository);

  /// Executes the use case to delete a position by its ID
  Future<void> call(int id) {
    return repository.deletePosition(id);
  }
}
