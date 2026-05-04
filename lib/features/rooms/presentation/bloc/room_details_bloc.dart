import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// BLoC for managing room details (inventory and employees)
class RoomDetailsBloc extends Bloc<RoomDetailsEvent, RoomDetailsState> {
  /// Use case to fetch all inventories
  final GetInventoriesUseCase getInventoriesUseCase;

  /// Use case to fetch all employees
  final GetEmployeesUseCase getEmployeesUseCase;

  /// Use case to fetch all categories
  final GetCategoriesUseCase getCategoriesUseCase;

  /// Use case to fetch all positions
  final GetPositionsUseCase getPositionsUseCase;

  /// Creates a [RoomDetailsBloc] with required use cases
  RoomDetailsBloc({
    required this.getInventoriesUseCase,
    required this.getEmployeesUseCase,
    required this.getCategoriesUseCase,
    required this.getPositionsUseCase,
  }) : super(const RoomDetailsInitial()) {
    on<LoadRoomDetailsEvent>(_onLoadDetails);
  }

  Future<void> _onLoadDetails(
    LoadRoomDetailsEvent event,
    Emitter<RoomDetailsState> emit,
  ) async {
    emit(const RoomDetailsLoading());
    try {
      final allInventory = await getInventoriesUseCase();
      final allEmployees = await getEmployeesUseCase();
      final categories = await getCategoriesUseCase();
      final positions = await getPositionsUseCase();

      final roomInventory = allInventory.filterByRoom(event.roomId);
      final roomEmployees = allEmployees.filterByRoom(event.roomId);

      emit(RoomDetailsLoaded(
        inventory: roomInventory,
        employees: roomEmployees,
        categories: categories,
        positions: positions,
        employeeMap: {for (final e in allEmployees) e.id: e.name},
        positionMap: {for (final p in positions) p.id: p.name},
      ));
    } catch (e) {
      emit(const RoomDetailsError(AppFailure.database));
    }
  }
}
