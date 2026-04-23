import '../../domain/entities/room_entity.dart';

/// Data model representing a room for data layer operations
class RoomModel {
  /// Unique identifier of the room
  final int id;

  /// Name of the room
  final String name;

  /// Description of the room (optional)
  final String? description;

  /// Timestamp of record creation
  final DateTime createdAt;

  /// Creates a [RoomModel] with the given parameters
  RoomModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
  });

  RoomEntity toEntity() => RoomEntity(
    id: id,
    name: name,
    description: description,
    createdAt: createdAt,
  );

  factory RoomModel.fromEntity(RoomEntity entity) => RoomModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    createdAt: entity.createdAt,
  );

  factory RoomModel.fromMap(Map<String, dynamic> map) => RoomModel(
    id: map['id'] as int,
    name: map['name'] as String,
    description: map['description'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'createdAt': createdAt.millisecondsSinceEpoch,
  };
}
