import 'package:inventory_p_shalaev/features/positions/data/datasources/positions_local_datasource.dart';
import 'package:inventory_p_shalaev/features/positions/data/models/position_model.dart';
import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';
import 'package:inventory_p_shalaev/features/positions/domain/repositories/position_repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionsLocalDataSource localDataSource;

  const PositionRepositoryImpl(this.localDataSource);

  @override
  Future<List<PositionEntity>> getPositions() async {
    final models = await localDataSource.getPositions();

    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PositionEntity> createPosition(PositionEntity position) async {
    final model = PositionModel(
      id: position.id,
      name: position.name,
      createdAt: position.createdAt,
    );
    final result = await localDataSource.createPosition(model);

    return result.toEntity();
  }

  @override
  Future<void> updatePosition(PositionEntity position) async {
    final model = PositionModel(
      id: position.id,
      name: position.name,
      createdAt: position.createdAt,
    );
    await localDataSource.updatePosition(model);
  }

  @override
  Future<void> deletePosition(int id) async {
    await localDataSource.deletePosition(id);
  }
}
