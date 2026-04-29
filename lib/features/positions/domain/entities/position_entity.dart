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
