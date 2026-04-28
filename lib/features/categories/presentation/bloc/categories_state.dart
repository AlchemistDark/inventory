import 'package:equatable/equatable.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/categories/domain/entities/category_entity.dart';

/// Base class for all category states
abstract class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];

  /// Constant constructor for subclasses
  const CategoriesState();
}

/// Initial state for categories
class CategoriesInitial extends CategoriesState {
  /// Creates a [CategoriesInitial] state
  const CategoriesInitial();
}

/// State indicating that categories are being loaded
class CategoriesLoading extends CategoriesState {
  /// Creates a [CategoriesLoading] state
  const CategoriesLoading();
}

/// State indicating that categories have been loaded successfully
class CategoriesLoaded extends CategoriesState {
  /// List of loaded categories
  final List<CategoryEntity> categories;

  @override
  List<Object?> get props => [categories];

  /// Creates a [CategoriesLoaded] state
  const CategoriesLoaded(this.categories);
}

/// State indicating an error occurred while working with categories
class CategoriesError extends CategoriesState {
  /// The failure type
  final AppFailure failure;

  @override
  List<Object?> get props => [failure];

  /// Creates a [CategoriesError] state
  const CategoriesError(this.failure);
}
