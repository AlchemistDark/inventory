import 'package:equatable/equatable.dart';

/// Domain entity representing a room
class RoomEntity extends Equatable {
  /// Unique identifier of the room
  final int id;

  /// Name of the room
  final String name;

  /// Description of the room (optional)
  final String? description;

  /// Timestamp of record creation
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, description, createdAt];

  /// Creates a [RoomEntity] with the given parameters
  const RoomEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
  });
}
