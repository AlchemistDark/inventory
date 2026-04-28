import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/categories/domain/repositories/categories_repository.dart';
import 'package:inventory_p_shalaev/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:inventory_p_shalaev/features/categories/presentation/bloc/categories_event.dart';
import 'package:inventory_p_shalaev/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final CategoriesRepository repository;

  CategoriesBloc({
    required this.getCategoriesUseCase,
    required this.repository,
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
      await repository.createCategory(event.category.name);
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
      await repository.updateCategory(event.category.id, event.category.name);
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
      await repository.deleteCategory(event.id);
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(const CategoriesError(AppFailure.database));
    }
  }
}
