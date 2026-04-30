import 'package:equatable/equatable.dart';

/// Domain entity representing an employee position.
class PositionEntity extends Equatable {
  /// Unique identifier for the position.
  final int id;

  /// Name of the position (e.g., "Developer", "Manager").
  final String name;

  /// Timestamp when the position record was created.
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, createdAt];

  /// Creates a [PositionEntity].
  const PositionEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}

/// Extension for [Iterable] of [PositionEntity] to provide utility methods.
extension PositionListX on Iterable<PositionEntity> {
  /// Returns the name of the position with the given [id],
  /// or [fallback] if not found.
  String getNameById(int? id, {required String fallback}) {
    if (id == null) {
      return fallback;
    }

    for (final position in this) {
      if (position.id == id) {
        return position.name;
      }
    }

    return fallback;
  }

  /// Returns the ID of the position with the given [name], or null if not found.
  int? getIdByName(String name) {
    for (final position in this) {
      if (position.name == name) {
        return position.id;
      }
    }

    return null;
  }
}
