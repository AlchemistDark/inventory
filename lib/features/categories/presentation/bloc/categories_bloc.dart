import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the state and operations of the categories list
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  /// Use case for retrieving categories
  final GetCategoriesUseCase getCategoriesUseCase;

  /// Use case for creating a category
  final CreateCategoryUseCase createCategoryUseCase;

  /// Use case for updating a category
  final UpdateCategoryUseCase updateCategoryUseCase;

  /// Use case for deleting a category
  final DeleteCategoryUseCase deleteCategoryUseCase;

  /// Creates a [CategoriesBloc] with the required dependencies
  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.createCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(const CategoriesInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<CreateCategoryEvent>(_onCreateCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesLoading());
    try {
      final categories = await getCategoriesUseCase();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(const CategoriesError(AppFailure.database));
    }
  }

  Future<void> _onCreateCategory(
    CreateCategoryEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      await createCategoryUseCase(event.category);
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(const CategoriesError(AppFailure.database));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      await updateCategoryUseCase(event.category);
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(const CategoriesError(AppFailure.database));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      await deleteCategoryUseCase(event.id);
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(const CategoriesError(AppFailure.database));
    }
  }
}
