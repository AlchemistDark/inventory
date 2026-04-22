import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;

  const PositionEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt];
}
