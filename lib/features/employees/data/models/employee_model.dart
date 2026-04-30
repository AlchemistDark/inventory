import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';

/// Data model representing an employee for data layer operations
class EmployeeModel {
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

  /// Creates an [EmployeeModel] with the given parameters
  EmployeeModel({
    required this.id,
    required this.name,
    required this.positionId,
    required this.createdAt,
    this.roomId,
  });

  factory EmployeeModel.fromEntity(EmployeeEntity entity) => EmployeeModel(
    id: entity.id,
    name: entity.name,
    positionId: entity.positionId,
    roomId: entity.roomId,
    createdAt: entity.createdAt,
  );

  factory EmployeeModel.fromMap(Map<String, dynamic> map) => EmployeeModel(
    id: map['id'] as int,
    name: map['name'] as String,
    positionId: map['positionId'] as int,
    roomId: map['roomId'] as int?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  EmployeeEntity toEntity() => EmployeeEntity(
    id: id,
    name: name,
    positionId: positionId,
    roomId: roomId,
    createdAt: createdAt,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'positionId': positionId,
      'roomId': roomId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };

    if (id > 0) {
      map['id'] = id;
    }
    
    return map;
  }
}
