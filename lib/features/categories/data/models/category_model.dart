import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  // Конвертация модели в entity
  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, createdAt: createdAt);
  }

  // Конвертация из entity в модель
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
    );
  }

  // Конвертация из map (из БД)
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  // Конвертация в map (для БД)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}
