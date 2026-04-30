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

/// Extension for [Iterable] of [RoomEntity] to provide utility methods.
extension RoomListX on Iterable<RoomEntity> {
  /// Returns the name of the room with the given [id],
  /// or [fallback] if not found.
  String getNameById(int? id, {required String fallback}) {
    if (id == null) {
      return fallback;
    }

    for (final room in this) {
      if (room.id == id) {
        return room.name;
      }
    }

    return fallback;
  }

  /// Returns the ID of the room with the given [name], or null if not found.
  int? getIdByName(String name) {
    for (final room in this) {
      if (room.name == name) {
        return room.id;
      }
    }

    return null;
  }
}
