import 'package:equatable/equatable.dart';

/// Domain entity representing a category
class CategoryEntity extends Equatable {
  /// Unique identifier of the category
  final int id;

  /// Name of the category
  final String name;

  /// Description of the category (optional)
  final String? description;

  /// Timestamp of record creation
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, description, createdAt];

  /// Creates a [CategoryEntity] with the given parameters
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
  });
}
