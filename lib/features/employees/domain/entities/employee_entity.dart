import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int id;
  final String name;
  final int positionId;
  final int? roomId;
  final DateTime createdAt;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.positionId,
    required this.createdAt,
    this.roomId,
  });

  @override
  List<Object?> get props => [id, name, positionId, roomId, createdAt];
}
