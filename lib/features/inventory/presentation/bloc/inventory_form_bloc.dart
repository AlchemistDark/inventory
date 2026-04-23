import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryFormBloc extends Bloc<InventoryFormEvent, InventoryFormState> {
  final EmployeesLocalDataSource employeesDataSource;
  final CategoriesLocalDataSource categoriesDataSource;
  final RoomsLocalDataSource roomsDataSource;
  final CreateInventoryUseCase createInventoryUseCase;
  final UpdateInventoryUseCase updateInventoryUseCase;

  InventoryFormBloc({
    required this.employeesDataSource,
    required this.categoriesDataSource,
    required this.roomsDataSource,
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
      final rooms = await roomsDataSource.getRooms();

      final defaultEmployeeId = employees.where((e) => e.name == 'Администратор').firstOrNull?.id;
      final defaultCategoryId = categories.where((c) => c.name == 'Не определено').firstOrNull?.id;
      final defaultRoomId = rooms.where((r) => r.name == 'Не определено').firstOrNull?.id;

      emit(InventoryFormMetadataLoaded(
        employees: employees,
        categories: categories,
        rooms: rooms,
        defaultEmployeeId: defaultEmployeeId,
        defaultCategoryId: defaultCategoryId,
        defaultRoomId: defaultRoomId,
      ));
    } catch (e) {
      emit(InventoryFormError(e.toString()));
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
      emit(InventoryFormError(e.toString()));
    }
  }
}
