import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';

/// Base class for all category events
abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const CategoriesEvent();
}

/// Event to load all categories
class LoadCategoriesEvent extends CategoriesEvent {
  /// Creates a [LoadCategoriesEvent]
  const LoadCategoriesEvent();
}

/// Event to create a new category
class CreateCategoryEvent extends CategoriesEvent {
  /// The category to create
  final CategoryEntity category;

  @override
  List<Object?> get props => [category];

  /// Creates a [CreateCategoryEvent]
  const CreateCategoryEvent(this.category);
}

/// Event to update an existing category
class UpdateCategoryEvent extends CategoriesEvent {
  /// The category to update
  final CategoryEntity category;

  @override
  List<Object?> get props => [category];

  /// Creates an [UpdateCategoryEvent]
  const UpdateCategoryEvent(this.category);
}

/// Event to delete a category
class DeleteCategoryEvent extends CategoriesEvent {
  /// The ID of the category to delete
  final int id;

  @override
  List<Object?> get props => [id];

  /// Creates a [DeleteCategoryEvent]
  const DeleteCategoryEvent(this.id);
}
