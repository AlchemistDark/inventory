import '../entities/position_entity.dart';

abstract class PositionRepository {
  Future<List<PositionEntity>> getPositions();
  Future<PositionEntity> createPosition(PositionEntity position);
  Future<void> updatePosition(PositionEntity position);
  Future<void> deletePosition(int id);
}
