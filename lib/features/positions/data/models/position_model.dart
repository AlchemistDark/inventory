import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';

/// Data model for employee positions, providing serialization to/from database maps.
class PositionModel {
  /// Unique identifier for the position.
  final int id;

  /// Name of the position.
  final String name;

  /// Timestamp when the position was created.
  final DateTime createdAt;

  /// Creates a [PositionModel].
  PositionModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory PositionModel.fromEntity(PositionEntity entity) => PositionModel(
    id: entity.id,
    name: entity.name,
    createdAt: entity.createdAt,
  );

  factory PositionModel.fromMap(Map<String, dynamic> map) => PositionModel(
    id: map['id'] as int,
    name: map['name'] as String,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  PositionEntity toEntity() => PositionEntity(
    id: id,
    name: name,
    createdAt: createdAt,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };

    if (id > 0) {
      map['id'] = id;
    }
    
    return map;
  }
}
