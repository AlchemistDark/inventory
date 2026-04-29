import '../entities/position_entity.dart';
import '../repositories/position_repository.dart';

/// Use case for retrieving all available positions.
class GetPositionsUseCase {
  /// The repository used for position operations.
  final PositionRepository repository;

  /// Creates a [GetPositionsUseCase].
  GetPositionsUseCase(this.repository);

  Future<List<PositionEntity>> call() async {
    return await repository.getPositions();
  }
}
