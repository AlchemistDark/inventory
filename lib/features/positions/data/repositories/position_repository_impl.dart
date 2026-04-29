import 'package:inventory_p_shalaev/features/features.dart';

/// Implementation of [PositionRepository] using a local data source.
class PositionRepositoryImpl implements PositionRepository {
  /// The local data source for positions.
  final PositionsLocalDataSource localDataSource;

  /// Creates a [PositionRepositoryImpl].
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
