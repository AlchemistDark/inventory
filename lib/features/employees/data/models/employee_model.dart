import 'package:inventory_p_shalaev/features/employees/domain/entities/employee_entity.dart';

/// Data model representing an employee for data layer operations
class EmployeeModel {
  /// Unique identifier of the employee
  final int id;

  /// Full name of the employee
  final String name;

  /// IDs of the employee's positions
  final List<int> positionIds;

  /// ID of the employee's room (optional)
  final int? roomId;

  /// Timestamp of record creation
  final DateTime createdAt;

  /// Creates an [EmployeeModel] with the given parameters
  EmployeeModel({
    required this.id,
    required this.name,
    required this.positionIds,
    required this.createdAt,
    this.roomId,
  });

  factory EmployeeModel.fromEntity(EmployeeEntity entity) => EmployeeModel(
    id: entity.id,
    name: entity.name,
    positionIds: entity.positionIds,
    roomId: entity.roomId,
    createdAt: entity.createdAt,
  );

  factory EmployeeModel.fromMap(Map<String, dynamic> map, {List<int> positionIds = const []}) => EmployeeModel(
    id: map['id'] as int,
    name: map['name'] as String,
    positionIds: positionIds,
    roomId: map['roomId'] as int?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
  );

  EmployeeEntity toEntity() => EmployeeEntity(
    id: id,
    name: name,
    positionIds: positionIds,
    roomId: roomId,
    createdAt: createdAt,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'roomId': roomId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };

    if (id > 0) {
      map['id'] = id;
    }
    
    return map;
  }
}
