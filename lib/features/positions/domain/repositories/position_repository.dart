import '../entities/position_entity.dart';

/// Abstract repository for managing employee positions.
abstract class PositionRepository {
  /// Returns a list of all available positions.
  Future<List<PositionEntity>> getPositions();

  /// Creates a new position record.
  Future<PositionEntity> createPosition(PositionEntity position);

  /// Updates an existing position record.
  Future<void> updatePosition(PositionEntity position);

  /// Deletes a position record by its unique ID.
  Future<void> deletePosition(int id);
}
