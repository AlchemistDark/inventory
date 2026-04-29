import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, createdAt];

  const PositionEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}
