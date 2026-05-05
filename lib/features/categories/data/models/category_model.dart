import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';

/// Data model representing a category for data layer operations
class CategoryModel {
  /// Unique identifier of the category
  final int id;

  /// Name of the category
  final String name;

  /// Description of the category
  final String? description;

  /// Timestamp of record creation
  final DateTime createdAt;

  /// Creates a [CategoryModel] with the given parameters
  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.description,
  });

  /// Creates a model from a domain entity
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }

  /// Creates a model from a database map
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  /// Converts the model to a domain entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
    );
  }

  /// Converts the model to a database map
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };

    if (id > 0) {
      map['id'] = id;
    }
    
    return map;
  }

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}
