class CategoryEntity {
  final int id;
  final String name;
  final DateTime createdAt;

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

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ createdAt.hashCode;
}
