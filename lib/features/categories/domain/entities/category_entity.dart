import 'package:equatable/equatable.dart';

/// Domain entity representing a category
class CategoryEntity extends Equatable {
  /// Unique identifier of the category
  final int id;

  /// Name of the category
  final String name;

  /// Timestamp of record creation
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, createdAt];

  /// Creates a [CategoryEntity] with the given parameters
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}

/// Extension for [Iterable] of [CategoryEntity] to provide utility methods.
extension CategoryListX on Iterable<CategoryEntity> {
  /// Returns the name of the category with the given [id],
  /// or [fallback] if not found.
  String getNameById(int? id, {required String fallback}) {
    if (id == null) {
      return fallback;
    }

    for (final category in this) {
      if (category.id == id) {
        return category.name;
      }
    }

    return fallback;
  }

  /// Returns the ID of the category with the given [name], or null if not found.
  int? getIdByName(String name) {
    for (final category in this) {
      if (category.name == name) {
        return category.id;
      }
    }

    return null;
  }
}
