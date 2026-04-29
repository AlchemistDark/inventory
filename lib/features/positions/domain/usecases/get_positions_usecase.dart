import '../entities/position_entity.dart';
import '../repositories/position_repository.dart';

class GetPositionsUseCase {
  final PositionRepository repository;

  GetPositionsUseCase(this.repository);

  Future<List<PositionEntity>> call() async {
    return await repository.getPositions();
  }
}
