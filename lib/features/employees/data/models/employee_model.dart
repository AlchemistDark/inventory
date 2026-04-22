import '../../domain/entities/employee_entity.dart';

class EmployeeModel {
  final int id;
  final String name;
  final int positionId;
  final int? roomId;
  final DateTime createdAt;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.positionId,
    this.roomId,
    required this.createdAt,
  });

  EmployeeEntity toEntity() => EmployeeEntity(
    id: id,
    name: name,
    positionId: positionId,
    roomId: roomId,
    createdAt: createdAt,
  );

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

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'positionId': positionId,
    'roomId': roomId,
    'createdAt': createdAt.millisecondsSinceEpoch,
  };
}
