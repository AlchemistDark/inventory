import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing the logic of inventory creation and editing forms.
///
/// This BLoC is responsible for fetching required metadata (employees,
/// categories, rooms) and handling the submission of new or updated
/// inventory entities.
class InventoryFormBloc extends Bloc<InventoryFormEvent, InventoryFormState> {
  /// Use case for loading employees.
  final GetEmployeesUseCase getEmployeesUseCase;

  /// Use case for loading categories.
  final GetCategoriesUseCase getCategoriesUseCase;

  /// Use case for loading rooms.
  final GetRoomsUseCase getRoomsUseCase;

  /// Use case for creating a new inventory item.
  final CreateInventoryUseCase createInventoryUseCase;

  /// Use case for updating an existing inventory item.
  final UpdateInventoryUseCase updateInventoryUseCase;

  /// Creates an [InventoryFormBloc] with all required dependencies.
  InventoryFormBloc({
    required this.getEmployeesUseCase,
    required this.getCategoriesUseCase,
    required this.getRoomsUseCase,
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
      final employees = await getEmployeesUseCase();
      final categories = await getCategoriesUseCase();
      final rooms = await getRoomsUseCase();

      // We no longer look for "Not Defined" in DB. 
      // Defaults are null/empty by design.
      emit(InventoryFormMetadataLoaded(
        employees: employees,
        categories: categories,
        rooms: rooms,
        defaultEmployeeId: null,
        defaultCategoryId: null,
        defaultRoomId: null,
      ));
    } catch (e) {
      emit(const InventoryFormError(AppFailure.database));
    }
  }

  Future<void> _onSubmit(
    SubmitInventoryEvent event,
    Emitter<InventoryFormState> emit,
  ) async {
    if (state is! InventoryFormMetadataLoaded) {
      
      return;
    }

    emit(const InventoryFormLoading());
    try {
      // Clean categories before saving (e.g. remove duplicates)
      final cleanedInventory = event.inventory.copyWith(
        categoryIds: InventoryEntity.cleanCategoryIds(
          event.inventory.categoryIds,
        ),
      );

      if (event.isEdit) {
        await updateInventoryUseCase(cleanedInventory);
      } else {
        await createInventoryUseCase(cleanedInventory);
      }
      emit(const InventoryFormSuccess());
    } catch (e) {
      emit(const InventoryFormError(AppFailure.database));
    }
  }
}
