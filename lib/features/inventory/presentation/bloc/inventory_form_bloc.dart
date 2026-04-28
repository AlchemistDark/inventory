import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the logic of inventory creation and editing forms.
///
/// This BLoC is responsible for fetching required metadata (employees,
/// categories, rooms) and handling the submission of new or updated
/// inventory entities.
class InventoryFormBloc extends Bloc<InventoryFormEvent, InventoryFormState> {
  /// Data source for loading employees.
  final EmployeesLocalDataSource employeesDataSource;

  /// Data source for loading categories.
  final CategoriesLocalDataSource categoriesDataSource;

  /// Use case for creating a new inventory item.
  final CreateInventoryUseCase createInventoryUseCase;

  /// Use case for updating an existing inventory item.
  final UpdateInventoryUseCase updateInventoryUseCase;

  /// Creates an [InventoryFormBloc] with all required dependencies.
  InventoryFormBloc({
    required this.employeesDataSource,
    required this.categoriesDataSource,
    required this.createInventoryUseCase,
    required this.updateInventoryUseCase,
  }) : super(const InventoryFormInitial()) {
    on<LoadFormMetadataEvent>(_onLoadMetadata);
    on<SubmitInventoryEvent>(_onSubmit);
  }

  Future<void> _onLoadMetadata(
    LoadFormMetadataEvent event,
    Emitter<InventoryFormState> emit,
  ) async {
    emit(const InventoryFormLoading());
    try {
      final employees = await employeesDataSource.getEmployees();
      final categories = await categoriesDataSource.getCategories();

      // Find default values based on conventional names
      // ToDo Убрать 'Администратор' и 'Не определено'
      final defaultEmployeeId =
          employees.where((e) => e.name == 'Администратор').firstOrNull?.id;
      final defaultCategoryId =
          categories.where((c) => c.name == 'Не определено').firstOrNull?.id;

      emit(InventoryFormMetadataLoaded(
        employees: employees,
        categories: categories,
        defaultEmployeeId: defaultEmployeeId,
        defaultCategoryId: defaultCategoryId,
      ));
    } catch (e) {
      emit(const InventoryFormError(AppFailure.database));
    }
  }

  Future<void> _onSubmit(
    SubmitInventoryEvent event,
    Emitter<InventoryFormState> emit,
  ) async {
    emit(const InventoryFormLoading());
    try {
      if (event.isEdit) {
        await updateInventoryUseCase(event.inventory);
      } else {
        await createInventoryUseCase(event.inventory);
      }
      emit(const InventoryFormSuccess());
    } catch (e) {
      emit(const InventoryFormError(AppFailure.database));
    }
  }
}
