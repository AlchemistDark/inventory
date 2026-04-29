import '../../domain/entities/position_entity.dart';

class PositionModel {
  final int id;
  final String name;
  final DateTime createdAt;

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

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.millisecondsSinceEpoch,
  };
}
