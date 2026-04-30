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

  @override
  List<Object?> get props => [id, name, positionId, roomId, createdAt];

  /// Creates an [EmployeeEntity] with the given parameters
  const EmployeeEntity({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.positionId,
    this.roomId,
  });
}

/// Extension for [Iterable] of [EmployeeEntity] to provide utility methods.
extension EmployeeListX on Iterable<EmployeeEntity> {
  /// Returns the name of the employee with the given [id],
  /// or [fallback] if not found.
  String getNameById(int? id, {required String fallback}) {
    if (id == null) {
      return fallback;
    }

    for (final employee in this) {
      if (employee.id == id) {
        return employee.name;
      }
    }

    return fallback;
  }

  /// Returns the ID of the employee with the given [name], or null if not found.
  int? getIdByName(String name) {
    for (final employee in this) {
      if (employee.name == name) {
        return employee.id;
      }
    }

    return null;
  }

  /// Filters the employees by [roomId]
  List<EmployeeEntity> filterByRoom(int roomId) {
    return where((employee) => employee.roomId == roomId).toList();
  }

  /// Filters the employees by name [query] and [positionId]
  List<EmployeeEntity> search({String? query, int? positionId}) {
    return where((employee) {
      final matchesQuery = query == null ||
          employee.name.toLowerCase().contains(query.toLowerCase());
      final matchesPosition =
          positionId == null || employee.positionId == positionId;

      return matchesQuery && matchesPosition;
    }).toList();
  }
}
