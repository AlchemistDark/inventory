import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;

  const RoomEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, description, createdAt];
}
