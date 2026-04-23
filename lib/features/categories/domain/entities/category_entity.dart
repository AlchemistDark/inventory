/// Domain entity representing a category
class CategoryEntity {
  /// Unique identifier of the category
  final int id;

  /// Name of the category
  final String name;

  /// Timestamp of record creation
  final DateTime createdAt;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;

  /// Creates a [CategoryEntity] with the given parameters
  CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  String toString() =>
      'CategoryEntity(id: $id, name: $name, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt;
}
