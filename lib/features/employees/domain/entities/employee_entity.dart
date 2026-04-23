import 'package:equatable/equatable.dart';

/// Domain entity representing an employee
class EmployeeEntity extends Equatable {
  /// Unique identifier of the employee
  final int id;

  /// Full name of the employee
  final String name;

  /// ID of the employee's position
  final int positionId;

  /// ID of the employee's room (optional)
  final int? roomId;

  /// Timestamp of record creation
  final DateTime createdAt;

  /// Creates an [EmployeeEntity] with the given parameters
  const EmployeeEntity({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.positionId,
    this.roomId,
    
  });

  @override
  List<Object?> get props => [id, name, positionId, roomId, createdAt];
}
